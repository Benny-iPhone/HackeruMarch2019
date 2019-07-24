//
//  Utils.swift
//  WidgetProject
//
//  Created by Benny Davidovitz on 24/07/2019.
//  Copyright © 2019 WebTech. All rights reserved.
//

import UIKit
import CoreLocation

extension UserDefaults{
    static var hackerUJuly2019Defaults : UserDefaults?{
        return UserDefaults(suiteName: "group.hackerUJuly2019")
    }
}

struct Util {
    static var copiedText : String?{
        return UIPasteboard.general.string
    }
    
    static func copy(str : String){
        UIPasteboard.general.string = str
    }
    
    static var dummyLocation : CLLocation?{
        return CLLocation(latitude: 32.10, longitude: 34.55)
    }
    
    static var locaionFromDisk : CLLocation?{
        guard let dict = UserDefaults.hackerUJuly2019Defaults?.dictionary(forKey: "location"),
            let location = CLLocation(dict) else{
                debugPrint("no location found")
                return nil
        }
        
        return location
    }
}

extension CLLocation{
    var dictionary : [String:Any]{
        return [
            "latitude":self.coordinate.latitude,
            "longitude":self.coordinate.longitude
        ]
    }
    
    convenience init?(_ dict : [String:Any]){
        guard let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double else{
                return nil
        }
        
        self.init(latitude: latitude, longitude: longitude)
    }
}
