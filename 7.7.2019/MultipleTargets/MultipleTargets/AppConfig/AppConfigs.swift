//
//  AppConfigs.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

struct AppConfigs : IAppConfig{
    
    init() {
        print("Passenger App")
    }
    
    var mainSegueId: String {
        return "passengerSegue"
    }
    
    
}

struct AppUIConfigs : IAppUIConfig{
    var tintColor: UIColor { return .purple }
    var bgColor: UIColor { return .lightGray }
}
