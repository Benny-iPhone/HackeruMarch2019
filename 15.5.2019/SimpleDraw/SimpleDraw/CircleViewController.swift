//
//  CircleViewController.swift
//  SimpleDraw
//
//  Created by hackeru on 15/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {

    @IBOutlet weak var cView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        print(sender.value)
        cView.borderSize = CGFloat(sender.value)
        
    }
    
}
