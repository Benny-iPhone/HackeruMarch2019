//
//  CircleView.swift
//  SimpleDraw
//
//  Created by hackeru on 15/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

@IBDesignable class CircleView: UIView {
    private static let maxBorderSize : CGFloat = 25
    
    @IBInspectable var borderSize : CGFloat{
        get{
            return _borderSize
        }
        set{
            //setter
            if newValue < 1{
                _borderSize = 1
            } else if newValue > CircleView.maxBorderSize{
                _borderSize = CircleView.maxBorderSize
            } else {
                _borderSize = newValue
            }
            
            //re-draw
            //setNeedsDisplay()
        }
    }
    private var _borderSize : CGFloat = 1{
        didSet{
            //re-draw
            setNeedsDisplay()
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //refresh draw
        self.setNeedsDisplay()
    }
    
    private func makePadding(for rect : CGRect, by inset : CGFloat) -> CGRect
    {
        var rect = rect
        rect.origin.x += inset * 0.5
        rect.origin.y += inset * 0.5
        rect.size.width -= inset
        rect.size.height -= inset
        
        return rect
    }
    
    private func calculateCircleRect() -> CGRect
    {
        var circleRect = self.bounds
        
        if circleRect.width < circleRect.height{
            let diff = circleRect.height - circleRect.width
            circleRect.origin.y = diff / 2
        }
        
        if circleRect.height < circleRect.width{
            let diff = circleRect.width - circleRect.height
            circleRect.origin.x = diff / 2
        }
        
        let size = min(circleRect.width, circleRect.height)
        circleRect.size.width = size
        circleRect.size.height = size
        
        return circleRect
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        var circleRect = calculateCircleRect()
        circleRect = self.makePadding(for: circleRect, by: borderSize)
        context.addEllipse(in: circleRect)
        
        context.setLineWidth(borderSize)
        
        context.strokePath()
        
        
    }
    
    

}
