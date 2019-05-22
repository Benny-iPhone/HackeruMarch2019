//
//  TemplateImageView.swift
//  ProfilePicImageView
//
//  Created by hackeru on 22/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TemplateImageView: UIImageView {

    override var image : UIImage?{
        get{
            return super.image
        }
        set{
            super.image = newValue?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    override var highlightedImage: UIImage?{
        get{
            return super.highlightedImage
        }
        set{
            super.highlightedImage = newValue?.withRenderingMode(.alwaysTemplate)
        }
    }
    //viewDidLoad alike, when created in .storyboard / .xib file
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup(){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.highlightedImage = self.highlightedImage?.withRenderingMode(.alwaysTemplate)
    }

}
