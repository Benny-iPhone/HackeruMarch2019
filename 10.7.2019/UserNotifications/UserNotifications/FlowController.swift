//
//  FlowController.swift
//  NotificationsExample
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class FlowController {
    
    static let shared = FlowController()
    
    weak var window : UIWindow?
    
    func displayUI(for eventId : String, title : String){
        
        //TODO: - Validate Main Thread
        
        let event = Event(id: eventId, title: title)
        let viewController = EventDetailsViewController.createVC()
        viewController.event = event
        
        //TODO: - Validate that no other view controller being presented at the moment
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
        
    }
}
