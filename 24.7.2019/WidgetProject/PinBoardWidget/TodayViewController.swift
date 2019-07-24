//
//  TodayViewController.swift
//  PinBoardWidget
//
//  Created by Benny Davidovitz on 24/07/2019.
//  Copyright © 2019 WebTech. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Text From Code... 2"
        //label.text = Util.dummyLocation?.description
        label.numberOfLines = 0
        //self.view.backgroundColor = .blue
        label.textColor = .black
        
        let screenWidth = UIScreen.main.bounds.width
        self.preferredContentSize = CGSize(width: screenWidth, height: 1_000)
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        // Do any additional setup after loading the view.
        loadLocationFromFile()
        
        if let text = UserDefaults.hackerUJuly2019Defaults?.string(forKey: "text"){
            print(text)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.label.text = Util.copiedText
        }
    }
    
    func loadDummyLocation(){
        label.text = Util.dummyLocation?.description
    }
    
    func loadLocationFromFile(){
        if let location = Util.locaionFromDisk{
            label.text = "Found Location From Disk" + "\n" + location.description
        } else {
            label.text = "No Location Found"
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: 1_000)
        }else if activeDisplayMode == .compact{
            self.preferredContentSize = CGSize(width: maxSize.width, height: 110)
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
