//
//  Animal.swift
//  Zoo
//
//  Created by hackeru on 07/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

struct Animal : Codable{
    let id : String
    let name : String
    
    static func readFromFile() -> [Animal]
    {
        //get file local url
        guard let url = Bundle.main.url(forResource: "zoo", withExtension: "json") else{
            return []
        }
        
        //read file to binary data
        guard let data = try? Data(contentsOf: url) else{
            return []
        }
        
        return (try? JSONDecoder().decode([Animal].self, from: data)) ?? []
        
    }
}

/*
struct Animal {
    let id : String
    let name : String
    
    //nillable init
    init?(_ dict : [String:Any]){
        guard let id = dict["id"] as? String else{
            return nil
        }

        self.id = id
        name = dict["name"] as? String ?? ""
    }
    
    static func readFromFile() -> [Animal]
    {
        //get file local url
        guard let url = Bundle.main.url(forResource: "zoo", withExtension: "json") else{
            return []
        }
        
        //read file to binary data
        guard let data = try? Data(contentsOf: url) else{
            return []
        }
        
        //parse binary data to json object
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) else{
            return []
        }
        
        //validate json format
        guard let rawArray = json as? [[String:Any]] else{ //Array of Dictionaries (Key - String, Value - Any)
            return []
        }
        
        return rawArray.compactMap{ Animal($0)} 
    }
}
*/










