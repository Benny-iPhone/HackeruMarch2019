//
//  CallCenter.swift
//  CallCentersHomework
//
//  Created by hackeru on 07/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

struct CallCenter : Codable{
    let id : String
    let name : String
    let phone : String
    
    static var all : [CallCenter]{
        get{
            
            guard let url = Bundle.main.url(forResource: "data", withExtension: "json"),
                let data = try? Data(contentsOf: url) else{
                    return []
            }
            
            return (try? JSONDecoder().decode([CallCenter].self, from: data)) ?? []
            
        }
    }
}
