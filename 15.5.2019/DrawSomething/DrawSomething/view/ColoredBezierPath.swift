//
//  ColoredBezierPath.swift
//  DrawSomething
//
//  Created by hackeru on 15/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ColoredBezierPath: UIBezierPath {
    var strokeColor : UIColor?
    
    convenience init(color : UIColor?) {
        self.init()
        strokeColor = color
    }
    
    override func stroke() {
        if let strokeColor = self.strokeColor{
            strokeColor.setStroke()
        }
        
        super.stroke()
    }
}
