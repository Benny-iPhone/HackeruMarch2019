//
//  LocationTracker.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import CoreLocation

typealias ILocationTrackerCallback = (CLLocation)->Void

protocol ILocationTracker : class{
    func start()
    func stop()
    var currentLocation : CLLocation? { get }
    var callback : ILocationTrackerCallback? { get set }
}

class LocationTracker : NSObject, CLLocationManagerDelegate{
    static let tracker : ILocationTracker = LocationTracker()
    private let manager : CLLocationManager
    private var isMonitoringLocation : Bool
    
    var callback: ILocationTrackerCallback?
    
    override init() {
        isMonitoringLocation = false
        manager = CLLocationManager()
        callback = nil
        super.init()
        
        manager.activityType = .fitness
        manager.distanceFilter = 20
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
    }
    
    //MARK: - CLLocationManager Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //notify observer using callback
        callback?(locations[0])
        print(locations[0])
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if isMonitoringLocation{
            start()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension LocationTracker : ILocationTracker{
    func start() {
        self.isMonitoringLocation = true
        
        let authStatus = CLLocationManager.authorizationStatus()
        switch authStatus{
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func stop() {
        self.isMonitoringLocation = false
        
        manager.stopUpdatingLocation()
    }
    
    var currentLocation: CLLocation? {
        return manager.location
    }
    
    
    
    
}


