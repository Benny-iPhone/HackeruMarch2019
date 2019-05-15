//
//  ViewController.swift
//  SimpleDraw
//
//  Created by hackeru on 15/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        
        sender.view?.center = sender.location(in: self.view)
        
    }
    
}

