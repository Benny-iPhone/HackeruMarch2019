//
//  DrawView.swift
//  DrawSomething
//
//  Created by hackeru on 15/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
/*
@objc protocol IDrawView {
    func clearDraw()
 var strokeSize : CGFloat { get set }
}

extension DrawView : IDrawView{
    func clearDraw() {
        beziers = []
        setNeedsDisplay()
    }
}
*/
class DrawView: UIView {
    
    //MARK: - Non Private

    var pencilSize : CGFloat = 1
    var pencilColor : UIColor = .black
    
    func clear(){
        //clear points
        beziers = []
        //refresh draw
        setNeedsDisplay()
    }
    
    //each 'quest' of a finger is represented by UIBezierPath object
    private var beziers : [UIBezierPath] = []
    
    //MARK: - Override
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //only one finger
        self.isMultipleTouchEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        //validate touch instance
        guard let touch = touches.first else { return }
        //retrive location (CGPoint) of touch
        let point = touch.location(in: self)
        
        //a new 'quest' began, create an UIBezierPath instance for that
        let bezier = ColoredBezierPath()
        bezier.strokeColor = self.pencilColor
        bezier.lineWidth = self.pencilSize
        bezier.move(to: point)
        beziers += [bezier]
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        //validate touch instance
        guard let touch = touches.first else { return }
        //retrive location (CGPoint) of touch
        let point = touch.location(in: self)
        
        //draw a line to touch point, from recent touch point
        let bezier = beziers.last
        bezier?.addLine(to: point)
        //TODO
        //bezier?.addCurve(to: <#T##CGPoint#>, controlPoint1: <#T##CGPoint#>, controlPoint2: <#T##CGPoint#>)
        
        //refresh draw
        self.setNeedsDisplay()
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        beziers.forEach{ $0.stroke() }
        
    }
    

}
