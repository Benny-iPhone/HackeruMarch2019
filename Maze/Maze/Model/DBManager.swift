//
//  DBManager.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import CoreData

protocol IDBManager {
    func startActivity() -> Activity
    func stop(activity : Activity)
    func add(step : Step, to activity : Activity)
    func createStep(with latitude : Double, longitude : Double) -> Step
    func getAllActivities() -> [Activity]
    
    func saveContext()
}

class DBManager{
    
    static let manager : IDBManager = DBManager()
    
    private init(){
        //private init makes singleton, beacuse no one else can instantiate
    }
    
    var context : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Maze")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension DBManager : IDBManager{
    func startActivity() -> Activity {
        //create new Activity instance in Database
        let activity = Activity(context: self.context)
        activity.startDate = Date()
        
        //save to database
        saveContext()
        
        //return the new instance
        return activity
    }
    
    func stop(activity: Activity) {
        activity.endDate = Date()
        saveContext()
    }
    
    func add(step: Step, to activity: Activity) {
        //add step to path
        let set = activity.path ?? NSOrderedSet()
        let mutableSet = NSMutableOrderedSet(orderedSet: set)
        mutableSet.add(step)
        
        //update acticity
        activity.path = mutableSet
        //save
        saveContext()
    }
    
    func createStep(with latitude: Double, longitude: Double) -> Step {
        //Create
        let step = Step(context: self.context)
        step.latitude = latitude
        step.longitude = longitude
        step.date = Date()
        //Save
        saveContext()
        //Return
        return step
    }
    
    func getAllActivities() -> [Activity] {
        let request : NSFetchRequest<Activity> = Activity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false)]
        
        do{
            return try context.fetch(request)
        } catch {
            print(error)
            return []
        }
    }
    
    
    
    
}
