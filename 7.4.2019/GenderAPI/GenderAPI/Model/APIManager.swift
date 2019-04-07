//
//  APIManager.swift
//  GenderAPI
//
//  Created by hackeru on 07/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import Alamofire

struct APIManager{
    
    
    private var genderAPIToken : String{
        get{
            return "mvabClVyGwZEaKEpxW"
        }
    }

    func check(name : String, callback : @escaping (String?)->Void)
    {
        let urlString = "https://gender-api.com/get"
        let params : [String:Any] = [
            "name":name,
            "key":self.genderAPIToken
            ]
        
        Alamofire.request(urlString, method: .get, parameters: params).responseJSON { dataRes in
            guard let json = dataRes.result.value else{
                callback(nil)
                return
            }
            
            let dict = json as? [String:Any]
            let gender = dict?["gender"] as? String
            
            callback(gender)
        }
    }
    
    
}
