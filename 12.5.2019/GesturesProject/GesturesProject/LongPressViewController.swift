//
//  LongPressViewController.swift
//  GesturesProject
//
//  Created by hackeru on 12/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

extension UIColor{
    static var random : UIColor{
        get{
            // arc4random_uniform(256) => 0...255
            // CGFloat(arc4random_uniform(256)) / 255 => 0...1
            
            let red = CGFloat.random(in: 0...1) //CGFloat(arc4random_uniform(256)) / 255
            let green = CGFloat.random(in: 0...1) //CGFloat(arc4random_uniform(256)) / 255
            let blue = CGFloat.random(in: 0...1) //CGFloat(arc4random_uniform(256)) / 255
            return UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
    }
}

class LongPressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func longPressAction(_ sender : UILongPressGestureRecognizer){
        //validate that gesture is coupled to a view, and that the long press ended (and not began or moved)
        guard let targetView = sender.view,
            sender.state == .ended else{
                return
        }
        
        targetView.backgroundColor = .random
        
        
    }

}
