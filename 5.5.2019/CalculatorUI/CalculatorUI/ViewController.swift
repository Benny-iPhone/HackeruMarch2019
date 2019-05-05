//
//  ViewController.swift
//  CalculatorUI
//
//  Created by hackeru on 05/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var displayString : String = ""{
        didSet{
            label.text = displayString
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func digitAction(_ sender: UIButton) {
        let newStr = displayString + "\(sender.tag)"
        guard let intVal = Int(newStr) else { return }
        displayString = "\(intVal)"
    }
    
}

