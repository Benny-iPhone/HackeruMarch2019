//
//  DataManager.swift
//  LocaPeople
//
//  Created by hackeru on 03/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

class DataManager{
    //Singleton
    static let manager = DataManager()
    
    private init(){
        
    }
    
    func loadPeople() -> [Person]
    {
        /*
         1. Locate File (local url)
         2. Read File (binary data)
         3. Parse Json (Array of Dictionaries)
         4. Convert (Array of Person)
         */
        //1 Locate File (local url)
        guard let url = Bundle.main.url(forResource: "people", withExtension: "json") else{
            print("people.json not found")
            return []
        }
        //2 Read File (binary data)
        guard let data = try? Data(contentsOf: url) else{
            print("failed to read file")
            return []
        }
        
        /*
        do{
            let data = try Data(contentsOf: url)
        } catch {
            print("load data filed with error \(error)")
        }*/
        
        //3 Parse Json (Array of Dictionaries)
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else{
            print("data is not a valid json")
            return []
        }
        //                          [[String:Any]]
        guard let array = json as? Array<Dictionary<String,Any>> else{
            print("json is not in valid format")
            return []
        }
        
        //4 Convert (Array of Person)
        
        return array.compactMap{ Person($0) }
        
    }
    
}
