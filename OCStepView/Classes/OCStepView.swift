//
//  OCStepView.swift
//  OCStepView
//
//  Created by Evgene Podkorytov on 15.02.17.
//  Copyright © 2017 OverC. All rights reserved.
//

public let automaticDimension: CGFloat = -1.0

open class OCStepView: UIView {
    open var style: OCStepViewStyle! = OCStepViewStyleDefault() {
        didSet {
            setupStyle()
            setNeedsDisplay()
        }
    }
    
    open var items: [OCStepViewItem]! {
        didSet {
            itemSize = CGSize(width: max(itemSize.width, getNecessaryItemSize().width), height: max(itemSize.height, getNecessaryItemSize().height))
            setNeedsDisplay()
        }
    }
    open var currentIndex: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK:Private
    fileprivate let paragraphStyle = NSMutableParagraphStyle()
    
    //size
    fileprivate var itemSize: CGSize = .zero
    
    //MARK:Lifecycle
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        paragraphStyle.alignment = .center
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        paragraphStyle.alignment = .center
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    override open func draw(_ rect: CGRect) {
        let frameWidth = rect.width
        let width = itemSize.width
        let widthEdge = style.itemEdge.width
        let count = items.count
        let spacing: CGFloat = (style.spacing != automaticDimension) ? style.spacing : (((rect.width - widthEdge*2.0) - (width*CGFloat(count) + widthEdge*CGFloat(count - 1)))/CGFloat(count - 1) + widthEdge)
        
        let startX: CGFloat =  widthEdge
        let y = rect.midY
        
        let context = UIGraphicsGetCurrentContext()
        
        let x = startX
        var point = CGPoint(x: x, y: y)
        
        let path = UIBezierPath()
        
        func getItemStyle(index: Int) -> OCStepViewItemStyle {
            if !items[index].isEnabled {
                return style.disabled
            }else if index < currentIndex-1 {
                return style.active
            } else if index == currentIndex-1 {
                return style.current
            } else {
                return style.inactive
            }
        }
        
        for i in 0..<count {
            var itemStyle = getItemStyle(index: i)
            //
            var titleCenter = CGPoint(x: point.x + itemSize.width/2, y: point.y)
            
            let itemPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: point.x, y: point.y - itemSize.height/2), size: itemSize), cornerRadius: min(itemSize.width, itemSize.height)/2)
            itemPath.lineWidth = itemStyle.borderWidth
            
            context?.setFillColor(itemStyle.color.cgColor)
            itemPath.fill()
            
            if i == currentIndex-1 {
                let curItemSize = CGSize(width: itemSize.width + itemStyle.borderWidth*4, height: itemSize.height + itemStyle.borderWidth*4)
                let curItemPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: point.x - itemStyle.borderWidth*2, y: point.y - curItemSize.height/2), size: curItemSize), cornerRadius: min(curItemSize.width, curItemSize.height)/2)
                curItemPath.lineWidth = itemStyle.borderWidth
                
                itemPath.append(curItemPath)
            }
            
            context?.setStrokeColor(itemStyle.borderColor.cgColor)
            itemPath.stroke()
            
            path.append(itemPath)
            
            //draw title
            var attributes = [NSForegroundColorAttributeName : itemStyle.titleColor, NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: itemStyle.titleFont]
            let attributedTitle = NSAttributedString(string: items[i].title, attributes: attributes)
            
            drawTitle(attributedTitle, center: titleCenter)
            
            point.x += width + widthEdge/2
            
            //draw line
            if i != (count - 1) {
                let linePath = UIBezierPath()
                linePath.move(to: point)
                
                point.x += spacing - widthEdge
                
                linePath.addLine(to: point)
                point.x += widthEdge/2
                
                itemStyle = getItemStyle(index: i + 1)
                
                context?.setStrokeColor(itemStyle.borderColor.cgColor)
                linePath.stroke()
                context?.setFillColor(itemStyle.color.cgColor)
                linePath.fill()
                path.append(linePath)
            }
        }
    }
    //
    fileprivate func drawTitle(_ string: NSAttributedString, center: CGPoint) {
        var rect = string.boundingRect(with: CGSize(width: 1000, height: 1000), options: .usesFontLeading, context: nil)
        let size = rect.size
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        rect.origin = origin
        string.draw(in: rect)
    }
    //
    fileprivate func setupStyle() {
        itemSize = CGSize(width: max(itemSize.width, getNecessaryItemSize().width), height: max(itemSize.height, getNecessaryItemSize().height))
    }
    //
    fileprivate func getNecessaryItemSize() -> CGSize {
        let _items = items.sorted { (itemA, itemB) -> Bool in
            return itemA.title.characters.count >= itemB.title.characters.count
        }
        
        guard let string = _items.first?.title else {
            return .zero
        }
        
        var attributes = [NSFontAttributeName: style.active.titleFont]
        let attributedButtonTitle = NSAttributedString(string: string, attributes: attributes)
        
        let minSize = string.boundingRect(with: CGSize(width: 1000, height: 1000), options: .usesFontLeading, context: nil).size
        return CGSize(width: minSize.width + style.titleEdge.width, height: minSize.height + style.titleEdge.height)
    }
    
    //
    open func nextStep() {
        if currentIndex + 1 < items.count && items[currentIndex].isEnabled {
            currentIndex += 1
        }
    }
    
    open func prevStep() {
        if currentIndex - 1 >= 0 {
            currentIndex -= 1
        }
    }
}
