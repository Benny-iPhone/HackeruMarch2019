//
//  StartStopViewController.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class StartStopViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshButtonTitle()
    }
    
    private func refreshButtonTitle(){
        let hasActivity = AppManager.shared.currentActivity != nil
        startStopButton.setTitle(hasActivity ? "Stop" : "Start", for: .normal)
    }
    
    @IBAction func startStopAction(_ sender: Any) {
        let hasActivity = AppManager.shared.currentActivity != nil
        
        if hasActivity{
            AppManager.shared.stopCurrentActivity()
            self.performSegue(withIdentifier: "listSegue", sender: sender)
        } else {
            AppManager.shared.startNewActivity()
        }
        
        refreshButtonTitle()
        
        
    }
    

}
