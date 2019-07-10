//
//  NotificationViewController.swift
//  NoteContentExt
//
//  Created by hackeru on 10/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    struct FlightDetails {
        let number : String
        let gate : String
        let time : String
        
        init?(_ dict : [String:String]?){
            number = dict?["number"] ?? ""
            gate = dict?["gate"] ?? ""
            time = dict?["time"] ?? ""
        }
    }
    

    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var gateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        
        //self.preferredContentSize = CGSize(width: 320, height: 80)
        
        flightNumberLabel.text = ""
        gateLabel.text = ""
        timeLabel.text = ""
    }
    
    func didReceive(_ notification: UNNotification) {
        let flightDict = notification.request.content.userInfo["flight_details"] as? [String:String]
        let flight = FlightDetails(flightDict)
        
        flightNumberLabel.text = flight?.number
        gateLabel.text = flight?.gate
        timeLabel.text = flight?.time
    }

}
