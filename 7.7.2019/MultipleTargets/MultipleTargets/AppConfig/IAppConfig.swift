//
//  AppConfig.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

protocol IAppUIConfig {
    var tintColor : UIColor{ get }
    var bgColor : UIColor { get }
}


protocol IAppConfig {
    var mainSegueId : String { get }
}
