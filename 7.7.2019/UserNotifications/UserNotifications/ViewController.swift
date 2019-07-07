//
//  ViewController.swift
//  UserNotifications
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        guard let text = textField.text, text.count > 0 else{
            let alert = UIAlertController(title: "Error", message: "Text is Empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print(action.title ?? "")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        createNotification(with: text, delay: 15)
    }
    
    @IBAction func makeImageNotification(_ sender : Any){
        
        guard let url = Bundle.main.url(forResource: "image", withExtension: "jpg") else {
            return
        }
        
        createNotification(with: "Image", delay: 15, attachmentUrl: url)
        
    }
    @IBAction func createVideoNotification(_ sender: Any) {
        
        guard let url = Bundle.main.url(forResource: "video2", withExtension: "mp4") else {
            return
        }
        
        createNotification(with: "Video", delay: 15, attachmentUrl: url)
        
    }
    
    func requestNotificationPermission(with callback : @escaping (Bool)->Void){
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus{
            case .authorized:
                callback(true)
            case .denied:
                callback(false)
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound, .carPlay]) { (granted, error) in
                    callback(granted)
                }
            case .provisional:
                callback(true)
            }
        }
        
        
        
    }
    
    func createNotification(with text : String, delay : TimeInterval, attachmentUrl : URL? = nil){
        //-Custom sound-, -attachment-, -title-, -subtitle-, -thread id-, userInfo
        
        func request(){
            
            let content = UNMutableNotificationContent()
            
            if let url = attachmentUrl,
                let attach = try? UNNotificationAttachment(identifier: "identifier", url: url, options: nil){
                content.attachments = [attach]
            }
            
            
            let val = arc4random() % 2
            
            content.body = text
            content.badge = 1
            
            let soundName = UNNotificationSoundName(rawValue: "horse.wav")
            let sound = UNNotificationSound(named: soundName)
            content.sound = sound
//            if let sound = try? UNNotificationSound(named: UNNotificationSoundName(rawValue: )){
//                content.sound = sound
//            } else {
//                content.sound = UNNotificationSound.default
//            }
            content.title = "Notification Title \(val)"
            content.subtitle = "Notification Sub Title"
            content.threadIdentifier = "\(val)"
            content.userInfo = ["event_id":UUID().uuidString]
            
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error{
                    print(error)
                } else {
                    print("request notification success")
                }
            }
            
        }
        
        requestNotificationPermission { (granted) in
            if granted{
                request()
            }
        }
        
    }
    
}

