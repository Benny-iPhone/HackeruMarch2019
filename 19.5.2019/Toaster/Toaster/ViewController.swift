//
//  ViewController.swift
//  Toaster
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showNativeAlertAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "yo", message: "sup?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func showToastAction(_ sender: Any) {
        //ToastLabel.showToast(on: self.view, text: "Show Toast Test 🤣", position: .top)
        //self.view.toast("Show Toast Test 🤣")
        "Show Toast Test 🤣".toast()
    }
}

