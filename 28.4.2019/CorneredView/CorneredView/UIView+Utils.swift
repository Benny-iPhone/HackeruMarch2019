//
//  UIView+Utils.swift
//  CorneredView
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

extension UIView{
    
    @IBInspectable var borderColor : UIColor?{
        set{
            self.layer.borderColor = newValue?.cgColor
        }
        get{
            guard let cgColor = self.layer.borderColor else{ return nil }
            return UIColor(cgColor: cgColor)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat{
        set{
            self.layer.borderWidth = newValue
        }
        get{
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var masksToBounds : Bool{
        set{
            self.layer.masksToBounds = newValue
        }
        get{
            return self.layer.masksToBounds
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat{
        set{
            self.layer.cornerRadius = newValue
        }
        get{
            return self.layer.cornerRadius
        }
    }
    
}

