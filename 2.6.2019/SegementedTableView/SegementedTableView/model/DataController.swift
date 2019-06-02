//
//  DataController.swift
//  SegementedTableView
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

class DataController{
    
    static let shared = DataController()
    
    var allPeople : [Person] = []
    
    func fetchRecent(with callback : @escaping ([Person])->Void){
        let array = allPeople.sorted(by: { (p1, p2) -> Bool in
            return p1.dateValue.timeIntervalSince1970 > p2.dateValue.timeIntervalSince1970
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(array)
        }
    }
    
    func fetchPopular(with callback : @escaping ([Person])->Void){
        
        let array = allPeople.sorted(by: { (p1, p2) -> Bool in
            if p1.last_name == p2.last_name{ return p1.first_name < p2.first_name}
            return p1.last_name < p2.last_name
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(array)
        }
    }
    
    func fetchAlphabetic(with callback : @escaping ([Person])->Void){
        let array = self.allPeople.shuffled()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            callback(array)
        }
    }
}
