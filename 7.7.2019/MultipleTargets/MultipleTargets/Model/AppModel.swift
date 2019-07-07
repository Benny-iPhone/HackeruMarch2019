//
//  AppModel.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import CoreLocation

class AppModel{
    
    let appConfigs : IAppConfig = AppConfigs()
    let appUIConfigs : IAppUIConfig = AppUIConfigs()
    
    enum App : String{
        case passenger = "com.hackeru.MultipleTargets"
        case taxi = "com.hackeru.TaxiApp"
    }
    
    var currentApp : App{
        let bundleId = Bundle.main.bundleIdentifier!
        return App(rawValue: bundleId)!
    }
    
    static let model = AppModel()
    
    var currentLocation : CLLocation{
        return CLLocation(latitude: 49.7053824, longitude: 19.2911275)
    }
    
}
