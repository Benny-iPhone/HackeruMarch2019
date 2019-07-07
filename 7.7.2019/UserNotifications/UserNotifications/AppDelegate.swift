//
//  AppDelegate.swift
//  UserNotifications
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FlowController.shared.window = self.window
        
        application.applicationIconBadgeNumber = 0
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }


}

extension AppDelegate : UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let isAppInForeground = UIApplication.shared.applicationState == .active
        
        if isAppInForeground{
            completionHandler(.alert)
        } else {
            //app in background
            completionHandler([.alert, .badge, .sound])
        }
        
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let content = response.notification.request.content
        
        if let eventId = content.userInfo["event_id"] as? String{
            
            FlowController.shared.displayUI(for: eventId, title: content.body)
            
            print(eventId)
        }
        
        
        completionHandler()
    }
    
}

