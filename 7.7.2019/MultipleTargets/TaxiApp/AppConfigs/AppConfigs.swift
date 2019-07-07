//
//  AppConfigs.swift
//  TaxiApp
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

struct AppConfigs : IAppConfig{
    
    init() {
        print("Taxi App")
    }
    
    var mainSegueId: String { return "taxiSegue" }
    
    
}

struct AppUIConfigs : IAppUIConfig{
    var tintColor: UIColor { return .black }
    var bgColor: UIColor { return .blue }
}
