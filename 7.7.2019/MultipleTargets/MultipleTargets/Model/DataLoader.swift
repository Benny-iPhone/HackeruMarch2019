//
//  DataLoader.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation


struct DataLoader<T: Codable>{
    
    func loadDataFrom(file : String) -> [T]
    {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            return []
        }
        
        guard let data = try? Data(contentsOf: url) else { return [] }
        guard let arr = try? JSONDecoder().decode([T].self, from: data) else { return [] }
        return arr
    }
    
}
