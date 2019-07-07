//
//  Passenger.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import CoreLocation


struct Passenger : Codable{
    let id : String
    let first_name : String
    let last_name : String
    let latitude : Double
    let longitude : Double
 
    var location : CLLocation{
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}
