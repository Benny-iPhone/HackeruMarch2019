//
//  MainViewController.swift
//  PeekingCard
//
//  Created by Benny Davidovitz on 31/07/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func bottomEmbed(child : UIViewController, insets : UIEdgeInsets){
        //add child view-controller
        self.addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(child.view)
        
        child.didMove(toParent: self)
        
        //position card's view
        
        [
            child.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            child.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
            child.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -insets.top),
            child.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: insets.bottom)
            ].forEach{ $0.isActive = true }
    }
    
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func spawnCardAction(_ sender: UIButton) {
        sender.isEnabled = false
        
        let cardVC = CardViewController.createVC()
        self.bottomEmbed(child: cardVC, insets: UIEdgeInsets(top: 48, left: 24, bottom: 0, right: 24))
    }

}
