//
//  ViewController.swift
//  LabelCustomFont
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupCustomFontLabel()
        
        print(UIFont.familyNames)
        print("\n\n")
        print(UIFont.fontNames(forFamilyName: "Courier New"))
    }
    
    private func setupCustomFontLabel(){
        
        let myLabel = CustomFontLabel(frame: CGRect(x: 10, y: 200, width: self.view.bounds.width - 20, height: 30))
        myLabel.text = Date().description
        self.view.addSubview(myLabel)
        
    }


}

