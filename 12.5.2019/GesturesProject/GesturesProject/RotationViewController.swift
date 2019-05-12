//
//  RotationViewController.swift
//  GesturesProject
//
//  Created by hackeru on 12/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func rotationAction(_ sender : UIRotationGestureRecognizer){
        //statefull
        guard let targetView = sender.view else { return }
        
        let change = CGAffineTransform(rotationAngle: sender.rotation)
        let current = targetView.transform
        let total = current.concatenating(change)
        
        targetView.transform = total
        
        sender.rotation = 0
        
        
        //נאיבי
        /*
        switch sender.state {
        case .changed:
            sender.view?.transform = CGAffineTransform(rotationAngle: sender.rotation)
        case .ended:
            UIView.animate(withDuration: 0.7) {
                sender.view?.transform = .identity
            }
        default:
            break
        }
        */
        
        
    }

}
