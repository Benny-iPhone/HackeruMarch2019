//
//  CustomTextField.swift
//  LoginVCProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        
        textColor = .black
        font = UIFont.boldSystemFont(ofSize: 24)
        textAlignment = .left
        
        //clearButtonMode = .whileEditing
        clearsOnBeginEditing = true
        
        borderStyle = .none
        
        self.layer.borderColor = UIColor(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1).cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 16
        //self.layer.masksToBounds = true
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        //leftView?.backgroundColor = .red
        leftViewMode = .always
        
    }
    /*
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 12, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 12, dy: 0)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 12, dy: 0))
    }
*/
}
