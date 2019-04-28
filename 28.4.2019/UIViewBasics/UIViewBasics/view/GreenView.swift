//
//  GreenView.swift
//  UIViewBasics
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

//IBDesignable - see the design in stroyboard
@IBDesignable class GreenView: UIView {
    //from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
    }
    
    //from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.green.withAlphaComponent(0.6)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.backgroundColor = UIColor.green.withAlphaComponent(0.6)

    }

}
