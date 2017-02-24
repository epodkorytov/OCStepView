//
//  UIBezierPath+Extension.swift
//  OCStepView
//
//  Created by Evgene Podkorytov on 22.02.17.
//  Copyright © 2017 OverC. All rights reserved.
//

import Foundation

extension UIBezierPath {
    
    convenience init(roundedRect rect: CGRect, topLeftRadius r1: CGFloat, topRightRadius r2: CGFloat, bottomRightRadius r3: CGFloat, bottomLeftRadius r4: CGFloat) {
        let left  = CGFloat(M_PI)
        let up    = CGFloat(1.5*M_PI)
        let down  = CGFloat(M_PI_2)
        let right = CGFloat(0.0)
        self.init()
        addArc(withCenter: CGPoint(x: rect.minX + r1, y: rect.minY + r1), radius: r1, startAngle: left,  endAngle: up,    clockwise: true)
        addArc(withCenter: CGPoint(x: rect.maxX - r2, y: rect.minY + r2), radius: r2, startAngle: up,    endAngle: right, clockwise: true)
        addArc(withCenter: CGPoint(x: rect.maxX - r3, y: rect.maxY - r3), radius: r3, startAngle: right, endAngle: down,  clockwise: true)
        addArc(withCenter: CGPoint(x: rect.minX + r4, y: rect.maxY - r4), radius: r4, startAngle: down,  endAngle: left,  clockwise: true)
        close()
    }
    
    convenience init(roundedRect rect: CGRect, cornerRadius radius: CGFloat) {
        let left  = CGFloat(M_PI)
        let up    = CGFloat(1.5*M_PI)
        let down  = CGFloat(M_PI_2)
        let right = CGFloat(0.0)
        self.init()
        addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: left,  endAngle: up,    clockwise: true)
        addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: up,    endAngle: right, clockwise: true)
        addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: right, endAngle: down,  clockwise: true)
        addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: down,  endAngle: left,  clockwise: true)
        close()
    }
}
