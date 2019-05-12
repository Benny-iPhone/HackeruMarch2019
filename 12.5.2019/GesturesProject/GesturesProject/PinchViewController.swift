//
//  PinchViewController.swift
//  GesturesProject
//
//  Created by hackeru on 12/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class PinchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pinchAction(_ sender : UIPinchGestureRecognizer){
        
        guard let targetView = sender.view else{ return }
        
        let change = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
        let current = targetView.transform
        let total = current.concatenating(change)
        
        targetView.transform = total
        
        sender.scale = 1
        
    }
    
    @IBAction func rotationAction(_ sender : UIRotationGestureRecognizer){
        //statefull
        guard let targetView = sender.view else { return }
        
        let change = CGAffineTransform(rotationAngle: sender.rotation)
        let current = targetView.transform
        let total = current.concatenating(change)
        
        targetView.transform = total
        
        sender.rotation = 0
    }
    

}

extension PinchViewController : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
