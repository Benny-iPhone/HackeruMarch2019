//
//  ViewFromNib.swift
//  GettInteractive
//
//  Created by Daniel Huri on 12/12/18.
//  Copyright © 2018 huri. All rights reserved.
//

import UIKit

class ViewFromNib: UIView {
    
    private var view: UIView!
    
    var nibName: String {
        return type(of: self).className
    }
    
    func initNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            self.view = view
            addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            let views = Dictionary(dictionaryLiteral: ("view", view))
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: [], metrics: nil, views: views)
            addConstraints(horizontalConstraints)
            
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: [], metrics: nil, views: views)
            addConstraints(verticalConstraints)
        }
    }
}
