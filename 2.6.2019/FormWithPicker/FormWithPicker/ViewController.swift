//
//  ViewController.swift
//  FormWithPicker
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kinshipTextField: KinshipTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //kinshipTextField.kinship = .parent
    }

    @IBAction func kinshipEditingChanged(_ sender: KinshipTextField) {
        
        guard let k = sender.kinship else {return}
        print(#function)
        print(k.displayName)
        
    }
    
}

