//
//  ViewController.swift
//  ClickableLabel
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import FRHyperLabel

//https://github.com/null09264/FRHyperLabel/issues/29

class ViewController: UIViewController {

    @IBOutlet weak var termsOfUseLabel: FRHyperLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fullText = "By press continue I here by declare that I read and accept the terms of use and the privacy policy"
        
        termsOfUseLabel.attributedText = NSAttributedString(string: fullText, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)])
        
        setupLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLabel()
    }
    
    private func setupLabel(){
        //clean-up
        termsOfUseLabel.clearActionDictionary()
        
        //setup
        
        
        termsOfUseLabel.setLinkForSubstring("terms of use") { (label, text) in
            print("terms of use clicked, do something")
        }
        
        termsOfUseLabel.setLinkForSubstring("privacy policy") { (label, text) in
            print("privacy policy clicked, do something")
        }
        
    }

}

