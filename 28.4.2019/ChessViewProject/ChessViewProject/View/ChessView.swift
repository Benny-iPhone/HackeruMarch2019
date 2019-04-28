//
//  ChessView.swift
//  ChessViewProject
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

@IBDesignable class ChessView: UIView {
    
    @IBInspectable var length : UInt = 6{
        didSet{
            setup()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
    }
    
    private func setup(){
        
        //cleanup
        for obj in self.subviews{
            obj.removeFromSuperview()
        }
        
        //subviews.forEach{ $0.removeFromSuperview()}
        
        //setup
        
        self.backgroundColor = .clear
        //let w = self.bounds.width / columnsCount
        let size = min(self.bounds.width, self.bounds.height) / CGFloat(self.length)
        var rect = CGRect(x: 0, y: 0, width: size, height: size)
        
        for i in 0..<self.length{ //row
            for j in 0..<self.length{
                //column
                let subView : UIView
                if (i + j) % 2 == 0{
                    subView = BlackView(frame: rect)
                } else {
                    subView = WhiteView(frame: rect)
                }
                
                self.addSubview(subView)
                //prepare for next column in the same row
                rect.origin.x += size
                
            }
            
            //prepare for new line
            rect.origin.x = 0
            rect.origin.y += size
        }
        
        
    }

}
