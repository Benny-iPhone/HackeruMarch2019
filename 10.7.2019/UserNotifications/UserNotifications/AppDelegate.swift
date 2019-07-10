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
        //UIApplication.LaunchOptionsKey.
        application.applicationIconBadgeNumber = 0
        
        UNUserNotificationCenter.current().delegate = self
        
        //UIApplication.shared.registerForRemoteNotifications()
        requestDeviceToken()
        
        return true
    }
    
    func requestDeviceToken(){
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken as NSData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
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
        
        let content = response.notification.request.content.mutableCopy() as! UNMutableNotificationContent
        
        if response.actionIdentifier == "reminder"{
            //Make a Nudnik, you can use the same request id using 'response.notification.request.identifier'
            //let request = response.notification.request
            content.badge = ((content.badge?.intValue ?? 1) + 1) as NSNumber
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false))
            center.add(request) { (err) in
                if let err = err {
                    print(err)
                } else {
                    print("reminder action success")
                }
                
                completionHandler()
            }
            
            return
        }
        
        if response.actionIdentifier == "reject"{
            //DBManager.manager.deleteEvent(id)
            if Thread.isMainThread{
                UIApplication.shared.applicationIconBadgeNumber = 0
            } else {
                DispatchQueue.main.sync {
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
            }
            completionHandler()
            return
        }
        
        if let eventId = content.userInfo["event_id"] as? String{
            var title = content.body
            if let reply = (response as? UNTextInputNotificationResponse)?.userText{
                title += "\nUser: " + reply
            }
            FlowController.shared.displayUI(for: eventId, title: title)
            
            print(eventId)
        }
        
        
        completionHandler()
    }
    
}

