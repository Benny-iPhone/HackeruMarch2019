//
//  WelcomeViewController.swift
//  GradientProject
//
//  Created by hackeru on 17/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = .blue

        setupLabel()
    }
    
    private func setupLabel(){
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.text = "Welcome"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
