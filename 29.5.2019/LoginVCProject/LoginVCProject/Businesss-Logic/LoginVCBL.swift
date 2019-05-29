//
//  LoginVCBL.swift
//  LoginVCProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

//https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
extension String{
    var isValidEmail : Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

struct LoginVCBL{
    var email : String = ""
    var password : String = ""
    
    var isValid : Bool{
        get{
            return email.isValidEmail && password.count >= 6
        }
    }
    
    func login(with callback : @escaping (Bool)->Void){
        let success = email == "a@a.com" && password == "123456"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            callback(success)
        }
    }
}
















