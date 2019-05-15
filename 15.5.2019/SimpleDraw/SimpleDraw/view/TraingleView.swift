//
//  SimpleDrawView.swift
//  SimpleDraw
//
//  Created by hackeru on 15/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TraingleView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else{ return }
        
        let w = self.bounds.width
        let h = self.bounds.height
        
        context.move(to: CGPoint(x: w * 0.5, y: h * 0.1))
        context.addLine(to: CGPoint(x: w * 0.1, y: h * 0.9))
        context.addLine(to: CGPoint(x: w * 0.9, y: h * 0.9))
        
        context.closePath()
        
        context.setLineWidth(4)
        //context.setStrokeColor(UIColor.red.cgColor)
        UIColor.red.setStroke()
        
        //context.strokePath()
        //context.setFillColor(UIColor.orange.cgColor)
        UIColor.orange.setFill()
        //context.fillPath()
        
        context.drawPath(using: .fillStroke)
        
        
    }
    

}
