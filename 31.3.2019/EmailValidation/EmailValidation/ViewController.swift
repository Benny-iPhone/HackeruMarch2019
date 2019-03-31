//
//  ViewController.swift
//  EmailValidation
//
//  Created by hackeru on 31/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func textFieldEditingChangedAction(_ sender: UITextField) {
        print(#function)
   
        sender.textColor = (sender.text ?? "").isValidEmail ? .blue : .red
        
        //in this case the boolean is the optional that we resolve using ??
        sender.textColor = (sender.text?.isValidEmail ?? false) ? .blue : .red
        /*
        if let email = sender.text, self.isValidEmail(testStr: email){
            sender.textColor = UIColor.blue
        } else {
            sender.textColor = .red
        }
 */
        //print(textField.text ?? "no text")
    }
    
}


















