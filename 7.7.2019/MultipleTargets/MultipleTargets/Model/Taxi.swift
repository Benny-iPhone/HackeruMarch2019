//
//  Taxi.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import CoreLocation

struct Taxi : Codable{
    let id : String
    let username : String
    let latitude : Double
    let longitude : Double
    
    var location : CLLocation{
        return CLLocation(latitude: latitude, longitude: longitude)
    }

}
