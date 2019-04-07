//
//  ViewController.swift
//  GenderAPI
//
//  Created by hackeru on 07/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        indicatorView.hidesWhenStopped = true
    }

    @IBAction func checGenderAction(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else{
            return
        }
        
        sender.isEnabled = false //disable button
        
        indicatorView.startAnimating()
        APIManager().check(name: text) { [weak self](result) in
            self?.indicatorView.stopAnimating()
            if let result = result{
                sender.setTitle(result, for: .normal) //show result on button
                sender.isEnabled = true //re enable button
            }
        }
        
    }
    
}

