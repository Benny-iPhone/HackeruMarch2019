//
//  Utils.swift
//  EmailValidation
//
//  Created by hackeru on 31/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

//https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
extension String{
    var isValidEmail : Bool{
        get{ //getter
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
        }
    }
}
















