//
//  Person.swift
//  SegementedTableView
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

struct Person : Codable{
    let id : String
    let first_name : String
    let last_name : String
    let email : String
    let date : String
    
    var dateValue : Date{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter.date(from: date) ?? Date()
        }
    }
    
    static var allPeople : [Person]{
        get{
            
            guard let url = Bundle.main.url(forResource: "MOCK_DATA", withExtension: "json") else { return []}
            guard let data = try? Data(contentsOf: url) else { return [] }
            let result = try? JSONDecoder().decode([Person].self, from: data)
            return result ?? []
            
        }
    }
}
