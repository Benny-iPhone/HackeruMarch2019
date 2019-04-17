//
//  ViewController.swift
//  ColorPickerProject
//
//  Created by hackeru on 14/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetViewHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var targetView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        targetView.backgroundColor = .red
        
        targetView.layer.cornerRadius = targetViewHeightLayout.constant / 2
    }

    @IBAction func editColorAction(_ sender: Any) {
        
        let vc = ColorPickerViewController.createVC()
        vc.delegate = self
        vc.defaultColor = targetView.backgroundColor
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

extension ViewController : ColorPickerViewControllerDelegate{
    func colorPickerVC(_ controller: ColorPickerViewController, didSelectColor color: UIColor) {
        targetView.backgroundColor = color
    }
    
    
}

