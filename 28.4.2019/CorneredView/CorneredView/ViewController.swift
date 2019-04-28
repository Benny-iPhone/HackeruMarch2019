//
//  ViewController.swift
//  CorneredView
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //setupMyView()
        myView.cornerRadius = 24
        
    }
    
    private func setupMyView(){
        myView.layer.masksToBounds = true
        myView.layer.cornerRadius = 16
        myView.layer.borderWidth = 2
        myView.layer.borderColor = UIColor.black.cgColor
        myView.layer.shadowColor = UIColor.blue.cgColor
        myView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }


}

