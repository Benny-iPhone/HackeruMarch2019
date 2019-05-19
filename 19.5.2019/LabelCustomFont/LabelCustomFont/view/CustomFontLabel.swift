//
//  CustomFontLabel.swift
//  LabelCustomFont
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class CustomFontLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        //self.font = UIFont(name: "Arial-BoldMT", size: 24)
        //self.font = UIFont(name: "CourierNewPSMT", size: 24)
        self.font = UIFont(name: "OpenSansCondensed-Bold", size: 36)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tapGesture)
        
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapAction(){
        self.font = UIFont(name: self.font.fontName, size: self.font.pointSize + 1)
        self.sizeToFit()
        self.center = self.superview!.center
    }
}
