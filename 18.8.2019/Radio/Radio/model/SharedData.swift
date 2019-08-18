//
//  SharedData.swift
//  Radio
//
//  Created by Benny Davidovitz on 18/08/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import Foundation

class SharedData{
    static let shared = SharedData()
    
    var selectedStation : RadioStation?
    {
        get{
            //read from disk
            guard let data = UserDefaults.standard.data(forKey: "selectedStation") else{ return nil }
            return try? JSONDecoder().decode(RadioStation.self, from: data)
        }
        set{
            //write to disk
            let defaults = UserDefaults.standard

            defer{
                defaults.synchronize()
            }
            
            guard let station = newValue,
            let data = try? JSONEncoder().encode(station)
            else{
                defaults.set(nil, forKey: "selectedStation")
                return
            }
            
            defaults.set(data, forKey: "selectedStation")
            
        }
    }
    
}
