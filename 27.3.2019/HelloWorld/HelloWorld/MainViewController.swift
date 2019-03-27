//
//  ViewController.swift
//  HelloWorld
//
//  Created by hackeru on 27/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //clean text field, by setting to nil or ""
        textField.text = nil
        
        //open keyboard
        textField.becomeFirstResponder()
    }

    //action from UITextField on text change
    @IBAction func editingChangedAction(_ sender: UITextField) {
        // (sender.text ?? "") if left expression is nil, use the right one
        //helloLabel.text = "Hello" + (sender.text ?? "")
        var arr : [String] = ["Hello"]
        if let text = sender.text{
            arr += [text]
        }
        
        helloLabel.text = arr.joined(separator: " ")
    }
    
    //Action from button 'onClick' alike
    @IBAction func buttonHelloAction2(_ sender: Any) {
        
        helloLabel.text = "Hello World"
        //dont use sizeToFit when using auto layout
        helloLabel.sizeToFit()
        
    }
    
    //action from UITapGestureRecognizer (see Storyboard)
    @IBAction func tapAction(_ sender: Any) {
        //close keyboard
        if textField.isFirstResponder{
            textField.resignFirstResponder()
        } else {
            textField.becomeFirstResponder()
        }
    }
    //action from UITextField when Keyboard's return button clicked
    @IBAction func didEndOnExitAction(_ sender: UITextField) {
        //close keyboard
        sender.resignFirstResponder()
        
        //do whatever
    }
}














