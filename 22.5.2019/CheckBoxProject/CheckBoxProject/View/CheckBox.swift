//
//  CheckBox.swift
//  CheckBoxProject
//
//  Created by hackeru on 22/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class CheckBox: UIControl {

    private weak var imageView : UIImageView!
    @IBInspectable var isOn : Bool = false{
        didSet{
            refresh()
        }
    }
    
    @IBInspectable var isMultiSelect : Bool = false
    
    private func refresh(){
        imageView?.isHighlighted = isOn
        
        guard isOn == true, isMultiSelect == false else { return }
        superview?.subviews.compactMap{ $0 as? CheckBox}.filter{ $0 != self}.forEach{ $0.isOn = false}
    }
/*
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        populate()
    }
 */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        populate()
        setupGesture()
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAction(_ sender : Any){
        self.isOn = !self.isOn
        self.sendActions(for: .valueChanged)
        //imageView.isHighlighted = !imageView.isHighlighted
    }
    
    private func populate(){
        if self.imageView != nil{ //already exist, do not add twice
            return
        }
        
        let image = UIImage(named: "icons8-unchecked_checkbox")
        let highlightedImage = UIImage(named: "icons8-checked_checkbox")
        let imageView = UIImageView(image: image, highlightedImage: highlightedImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(imageView)
        self.imageView = imageView
        
        //center x
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //center y
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //equal width
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        //equal height
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        refresh()
        
    }

}
























