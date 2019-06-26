//
//  AppManager.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import CoreLocation

/*
class LocationTrackerJsonBased : ILocationTracker{
    
}

func test(){
    let testManager = AppManager(DBManager.manager, LocationTrackerJsonBased())
}
*/
class AppManager{
    
    static let shared = AppManager()
    
    private let dbManager : IDBManager
    private let locationTracker : ILocationTracker
    
    //private(set) = read only
    private(set) var currentActivity : Activity?
    
    //Dependency Injection, we can inject other instances than the shared instance objects.
    //For Example we may create DBManagerFirebase class that implements IDBManager, and use it
    //or LocationTrackerFake that subclass LocationTracker for testing purposes.
    init(_ dbManager : IDBManager = DBManager.manager,
         _ locationTracker : ILocationTracker = LocationTracker.tracker){
        self.dbManager = dbManager
        self.locationTracker = locationTracker
    }
    
    func startNewActivity(){
        if self.currentActivity != nil{
            stopCurrentActivity()
        }
        
        //start activity
        self.currentActivity = dbManager.startActivity()
        
        //add current location (to start of path)
        if let location = locationTracker.currentLocation{
            addStep(with: location)
        }
        
        //Observe New Location
        locationTracker.callback = { [weak self] location in
            self?.addStep(with: location)
        }
        
        //start tracking location after setup
        locationTracker.start()
        
        
    }
    
    //internal method to handle new location
    private func addStep(with location : CLLocation){
        guard let currentActivity = self.currentActivity else { return }
        let step = dbManager.createStep(with: location.coordinate.latitude, longitude: location.coordinate.longitude)
        dbManager.add(step: step, to: currentActivity)
    }
    
    func stopCurrentActivity(){
        guard let currentActivity = self.currentActivity else { return }
        //add current location (to end of path)
        if let location = locationTracker.currentLocation{
            addStep(with: location)
        }
        
        dbManager.stop(activity: currentActivity)
        locationTracker.stop()
        
        //Stop Observration
        locationTracker.callback = nil
        
        //clean up
        self.currentActivity = nil
        
    }
    
    func getAllActivities() -> [Activity]
    {
        return dbManager.getAllActivities()
    }
    
    
}

