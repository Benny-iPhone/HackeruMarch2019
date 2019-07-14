//
//  ViewController.swift
//  InternetConnection
//
//  Created by hackeru on 14/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class MyClass{
    
    class func start(){
        NotificationCenter.default.addObserver(self, selector: #selector(handle(note:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc class func handle(note : Notification){
        print(note.name)
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyClass.start()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(forName: .networkUpdate, object: AppModel.shared, queue: .main) { [weak self](note) in
            self?.handleNetwork(notification: note)
        }
        //NotificationCenter.default.addObserver(self, selector: #selector(handleNetwork(notification:)), name: .networkUpdate, object: /*nil*/AppModel.shared)
        
        update(with: .shared)
    }
    
    private func update(with model : AppModel){
        switch model.status {
        case .online:
            label.text = "ONLINE"
        case .offline:
            label.text = "OFFLINE"
        default:
            label.text = "?"
        }
        
        label.sizeToFit()
    }
    
    @objc func handleNetwork(notification : Notification){
        guard Thread.isMainThread else{
            DispatchQueue.main.async { [weak self] in
                self?.handleNetwork(notification: notification)
            }
            return
        }
        
        guard notification.name == .networkUpdate,
            let obj = notification.object as? AppModel else{
                return
        }
        
        update(with: obj)
        
    }


}

