//
//  RoundedImageView.swift
//  ProfilePicImageView
//
//  Created by hackeru on 22/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    private func setup(){
        
        self.layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
        self.layer.masksToBounds = true
        
    }
}
