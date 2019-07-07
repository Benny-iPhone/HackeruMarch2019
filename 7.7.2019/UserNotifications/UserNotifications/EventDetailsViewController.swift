//
//  EventDetailsViewController.swift
//  NotificationsExample
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

struct Event{
    let id : String
    let title : String
}

class EventDetailsViewController: UIViewController {

    var event : Event?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventIdLabel: UILabel!

    class func createVC() -> EventDetailsViewController{
        
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateUI()
    }
    
    private func populateUI(){
        guard let event = self.event else { return }
        titleLabel.text = event.title
        eventIdLabel.text = "Event ID: " + event.id
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
