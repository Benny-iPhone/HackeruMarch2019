//
//  SecondViewController.swift
//  TwoViewControllers
//
//  Created by hackeru on 14/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

@objc protocol SecondViewControllerDelegate{
    
    func secondViewController(_ controller : SecondViewController, didSelectText text : String?)
    
}


class SecondViewController: UIViewController {

    weak var delegate : SecondViewControllerDelegate?
    var text : String?
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = text
        //self.view.backgroundColor = .red

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.delegate?.secondViewController(self, didSelectText: textField.text)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
