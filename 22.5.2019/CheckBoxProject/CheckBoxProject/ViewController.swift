//
//  ViewController.swift
//  CheckBoxProject
//
//  Created by hackeru on 22/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func checkBoxAction(_ sender: CheckBox) {
        
        print(sender.isOn)
        
    }
    
}

