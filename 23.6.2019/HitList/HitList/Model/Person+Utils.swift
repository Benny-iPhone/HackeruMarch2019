//
//  Person+Utils.swift
//  HitList
//
//  Created by hackeru on 23/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

extension Person{
    enum Gender {
        case male
        case female
        
        static var all : [Gender] {
            return [.female, .male]
        }
        
        var title : String{
            switch self {
            case .male: return "Male"
            case .female: return "Female"
            }
        }
        
        var boolValue : Bool{ return self == .male }
        var intValue : Int { return boolValue ? 1 : 0 }
    }
    
    var personGender : Gender{
        set{
            self.gender = newValue.boolValue
        }
        get{
            return gender ? .male : .female
        }
    }
}
