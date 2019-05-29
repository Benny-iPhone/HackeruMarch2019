//
//  DataStore.swift
//  LoginVCProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

struct DataStore{
    
    var didLogin : Bool{
        return authToken != nil
    }
    
    var authToken : String?{
        get{
            return UserDefaults.standard.string(forKey: "authToken")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "authToken")
            UserDefaults.standard.synchronize()
        }
    }
    
}
