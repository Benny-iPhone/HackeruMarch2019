//
//  BaseViewController.swift
//  SubViewsOrder
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBackgroundImageView()
    }
    
    func setupBackgroundImageView(){
        
        let imageView = UIImageView(image: UIImage(named: "bg_image"))
        //self.view.addSubview(imageView)
        
        imageView.frame = self.view.bounds
        
        //self.view.sendSubviewToBack(imageView)
        
        self.view.insertSubview(imageView, at: 0)
        //self.view.insertSubview(imageView, at: self.view.subviews.count - 1)
        
        
    }
    


}
