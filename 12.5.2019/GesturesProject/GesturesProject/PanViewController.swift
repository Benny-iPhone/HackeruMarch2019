//
//  PanViewController.swift
//  GesturesProject
//
//  Created by hackeru on 12/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class PanViewController: UIViewController {

    @IBOutlet weak var blackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blackView.layer.cornerRadius = 60
    }
    
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        
        guard let blackView = sender.view else{ return }
        
        let point = sender.location(in: self.view)
        blackView.center = point
        
    }
    

}













