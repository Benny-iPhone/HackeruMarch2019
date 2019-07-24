//
//  ViewController.swift
//  WidgetProject
//
//  Created by Benny Davidovitz on 24/07/2019.
//  Copyright © 2019 WebTech. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readLocationFromDefaults()
    }
    
    func readLocationFromDefaults(){
        
        guard let location = Util.locaionFromDisk else{
            return
        }
        print(location)
    }
    @IBAction func textFieldReturnAction(_ sender: UITextField) {
        
        guard let str = sender.text,
            let defaults = UserDefaults.hackerUJuly2019Defaults else{
                return
        }
        
        defaults.set(str, forKey: "text")
        defaults.synchronize()
        
        Util.copy(str: str)
        
    }
    
    @IBAction func addLocationAction(_ sender: Any) {
        guard let location = Util.dummyLocation else{
            return
        }
        
        guard let defaults = UserDefaults.hackerUJuly2019Defaults else{ return}
        
        defaults.set(location.dictionary, forKey: "location")
        defaults.synchronize()
    }
    
}

