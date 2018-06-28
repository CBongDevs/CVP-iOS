//
//  DirectionalDisclosureIndicator.swift
//  CVP
//
//  Created by Andrew Thompson on 27/6/18.
//  Copyright © 2018 Andrew Thompson. All rights reserved.
//

import UIKit

@IBDesignable
class DirectionalDisclosureIndicator: UIView {
    @IBInspectable var disclosureColor: UIColor?
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            
            let R = CGFloat(5)
            let x = bounds.midX
            let y = bounds.midY
            
            context.move(to: CGPoint(x: x-R, y: y-R/2))
            context.addLine(to: CGPoint(x: x, y: y+R/2))
            context.addLine(to: CGPoint(x: x+R, y: y-R/2))
            
            context.setLineCap(CGLineCap.square)
            context.setLineJoin(CGLineJoin.miter)
            context.setLineWidth(2)
            (disclosureColor ?? .black).setStroke()
            context.strokePath()
        }
    }
}
