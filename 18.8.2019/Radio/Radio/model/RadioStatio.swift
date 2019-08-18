//
//  RadioStatio.swift
//  Radio
//
//  Created by Benny Davidovitz on 18/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import Foundation

//http://www.radiosure.com

struct RadioStation : Codable{
    let id : Int
    let name : String
    let url : String
    
    static func readJson(file : String) ->  [RadioStation]{
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        do{
            let arr = try JSONDecoder().decode([RadioStation].self, from: data)
            return arr
        } catch {
            print(error)
            return []
        }
        
    }
}

extension RadioStation : PlayableItem{
    var streamingUrl: URL{
        return URL(string: self.url)!
    }
}
