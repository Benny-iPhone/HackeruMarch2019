//
//  AppModel.swift
//  InternetConnection
//
//  Created by hackeru on 14/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import Reachability

extension Notification.Name{
    static var networkUpdate : Notification.Name{
        return Notification.Name(rawValue: "network_update_notification")
    }
}

class AppModel{
    static let shared = AppModel()
    
    var reachability : Reachability?
//
//    init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(handle(note:)), name: Notification.Name.reachabilityChanged, object: nil)
//    }
//
//    @objc func handle(note : Notification){
//        print("reachabilityChanged")
//    }
    
    func observerInternetConnection(){
        
        guard let reachability = Reachability() else {
            return
        }
        
        self.reachability = reachability
        /*
        reachability.whenReachable = { _ in
            print("connected")
        }
        
        reachability.whenUnreachable = { _ in
            print("offline")
        }*/
        
        do{
            try reachability.startNotifier()
        } catch {
            print(error)
        }
        
        checkStatus()
    }
    
    enum Status{
        case unknown
        case online
        case offline
    }
    
    var status : Status = .unknown{
        didSet{
            //noitfy if new value
            guard oldValue != status else { return }
            NotificationCenter.default.post(name: .networkUpdate, object: self, userInfo: nil)
        }
    }
    
    func checkStatus(){
        guard let r = self.reachability else { return }
        switch r.connection {
        case .cellular , .wifi:
            status = .online
        case .none:
            status = .offline
        }
        print(r.connection.description)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            AppModel.shared.checkStatus()
        }
    }
    
}
