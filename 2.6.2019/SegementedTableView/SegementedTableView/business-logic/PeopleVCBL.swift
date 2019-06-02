//
//  PeopleVCBL.swift
//  SegementedTableView
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation


protocol IPersonVCBL {
    var numberOfPeople : Int { get }
    func peopleAt(index : Int) -> Person
    var array : [Person] { get set }
    func fetch(with callback : @escaping ([Person])->Void)
}

struct RecentPeopleBL : IPersonVCBL{
    var numberOfPeople: Int{ return array.count}
    
    func peopleAt(index: Int) -> Person {
        return array[index]
    }
    
    var array : [Person] = []
    
    func fetch(with callback: @escaping ([Person]) -> Void) {
        DataController.shared.fetchRecent(with: callback)
    }
}

struct AlphabeticPeopleBL : IPersonVCBL{
    
    var numberOfPeople: Int{ return array.count}
    
    func peopleAt(index: Int) -> Person {
        return array[index]
    }
    
    var array : [Person]
    
    func fetch(with callback: @escaping ([Person]) -> Void) {
        DataController.shared.fetchAlphabetic(with: callback)
    }
    
}

struct PopularityPeopleBL : IPersonVCBL{
    var numberOfPeople: Int{ return array.count}
    
    func peopleAt(index: Int) -> Person {
        return array[index]
    }
    
    var array : [Person]
    
    func fetch(with callback: @escaping ([Person]) -> Void) {
        DataController.shared.fetchPopular(with: callback)
    }
}
