//
//  LocationTracker.swift
//  LocationsProject
//
//  Created by hackeru on 19/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import CoreLocation

extension Notification.Name{
    static var locationUpdate : Notification.Name{
        return Notification.Name(rawValue: "location_update_notification")
    }
}

class LocationTracker: NSObject {
    
    static let shared = LocationTracker()
    
    private let manager : CLLocationManager
    var location : CLLocation? { return manager.location }
    
    override init() {
        manager = CLLocationManager()
        super.init()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 50 //meter
        manager.delegate = self
    }
    
    func start(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            //one time location
            //manager.requestLocation()
        case .denied, .restricted:
            //TODO: - Offer user to enable location services in settings
            return
        case .notDetermined:
            //only foreground
            manager.requestWhenInUseAuthorization()
            //also background
            //manager.requestAlwaysAuthorization()
        }
    }
}

extension LocationTracker : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        start()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        NotificationCenter.default.post(name: .locationUpdate, object: self)
        
        print(locations[0])
    }
}
