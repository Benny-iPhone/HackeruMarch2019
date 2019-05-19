//
//  ViewController.swift
//  LabelProject
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateTitleLabel()
    }

    private func populateTitleLabel(){
        
        let text = "Hello User 😀" + " (" + UIDevice.current.name + ")" + " Running \(UIDevice.current.systemName) version \(UIDevice.current.systemVersion)"
        titleLabel.text = text //+ text + text + text + text + text
        /*
        titleLabel.font = UIFont.boldSystemFont(ofSize: 42)
        titleLabel.textColor = .red
        
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .black
        titleLabel.shadowColor = UIColor.white
        titleLabel.shadowOffset = CGSize(width: 1, height: 1)
        
        titleLabel.textAlignment = .center
 */
        
    }

}

