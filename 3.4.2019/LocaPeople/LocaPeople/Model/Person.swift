//
//  Person.swift
//  LocaPeople
//
//  Created by hackeru on 03/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

//https://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
fileprivate func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class Person{
    
    enum Gender : String{
        case male = "Male"
        case female = "Female"
    }
    
    let id : String
    let firstName : String
    let lastName : String
    let email : String
    let gender : Gender
    let color : UIColor
    
    init?(_ dict : [String:Any]) {
        guard let id = dict["id"] as? String else{
            print("id in data not valid \(dict)")
            return nil
        }
        
        guard let genderStr = dict["gender"] as? String,
            let gender = Gender(rawValue: genderStr) else{
            print("gender in data not valid \(dict)")
            return nil
        }
        
        self.id = id
        self.firstName = dict["first_name"] as? String ?? ""
        self.lastName = dict["last_name"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.gender = gender
        //TODO - Finish Color
        if let colorString = dict["hexColor"] as? String{
            self.color = hexStringToUIColor(hex: colorString)
        } else {
            self.color = .red
        }
    }
    
}





















