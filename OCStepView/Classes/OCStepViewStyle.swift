import UIKit

public protocol OCStepViewItemStyle {
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var color: UIColor { get }
    var titleFont: UIFont { get }
    var titleColor: UIColor { get }
}

public protocol OCStepViewStyle {
    var active: OCStepViewItemStyle { get }
    var inactive: OCStepViewItemStyle { get }
    var current: OCStepViewItemStyle { get }
    var disabled: OCStepViewItemStyle { get }

    var minItemSize: CGSize { get }
    var titleEdge: CGSize { get }
    var itemEdge: CGSize { get }
    
    var spacing: CGFloat { get }
}
//

public struct OCStepViewStyleActive: OCStepViewItemStyle {
    public var borderColor: UIColor = .blue
    public var borderWidth: CGFloat = 1.0
    public var color: UIColor = .blue
    public var titleFont: UIFont  = UIFont.systemFont(ofSize: 12)
    public var titleColor: UIColor = .gray
}

public struct OCStepViewStyleInactive: OCStepViewItemStyle {
    public var borderColor: UIColor = .darkGray
    public var borderWidth: CGFloat = 1.0
    public var color: UIColor = .yellow
    public var titleFont: UIFont  = UIFont.systemFont(ofSize: 12)
    public var titleColor: UIColor = .darkGray
}

public struct OCStepViewStyleCurrent: OCStepViewItemStyle {
    public var borderColor: UIColor = .blue
    public var borderWidth: CGFloat = 1.0
    public var color: UIColor = .blue
    public var titleFont: UIFont  = UIFont.systemFont(ofSize: 12)
    public var titleColor: UIColor = .white
}

public struct OCStepViewStyleDisabled: OCStepViewItemStyle {
    public var borderColor: UIColor = .gray
    public var borderWidth: CGFloat = 1.0
    public var color: UIColor = .clear
    public var titleFont: UIFont  = UIFont.systemFont(ofSize: 12)
    public var titleColor: UIColor = .gray
}

public struct OCStepViewStyleDefault: OCStepViewStyle {
    public var active: OCStepViewItemStyle = OCStepViewStyleActive()
    public var inactive: OCStepViewItemStyle = OCStepViewStyleInactive()
    public var current: OCStepViewItemStyle = OCStepViewStyleCurrent()
    public var disabled: OCStepViewItemStyle = OCStepViewStyleDisabled()
    
    public var minItemSize: CGSize = CGSize(width: 40.0, height: 40.0)
    public var titleEdge: CGSize = CGSize(width: 15.0, height: 10.0)
    public var itemEdge: CGSize = CGSize(width: 15.0, height: 10.0)
    
    public var spacing: CGFloat = -1.0
}
