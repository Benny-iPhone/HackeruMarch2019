//
//  TapViewController.swift
//  GesturesProject
//
//  Created by hackeru on 12/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TapViewController: UIViewController {

    @IBOutlet weak var centerYLayout: NSLayoutConstraint!
    @IBOutlet weak var centerXLayout: NSLayoutConstraint!
    
    @IBOutlet weak var singleTapGesture: UITapGestureRecognizer!
    @IBOutlet var myViewLayouts: [NSLayoutConstraint]!
    
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDoubleTapGesture()
        
    }
    
    private func setupDoubleTapGesture(){
        //create and hook action
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction(_:)))
        //make it double tap
        gesture.numberOfTapsRequired = 2
        //couple to view
        myView.addGestureRecognizer(gesture)
        
        //isolate double tap from single tap
        singleTapGesture.require(toFail: gesture)
    }
    
    @objc func doubleTapAction(_ sender : UITapGestureRecognizer){
        let isOriginalSize = myViewLayouts[0].constant == 150
        
        for layout in myViewLayouts{
            layout.constant = isOriginalSize ? 300 : 150
        }
        
        UIView.animate(withDuration: 0.7) { [weak self] in
            self?.view.layoutSubviews()
        }
    }
    
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        
        let point : CGPoint = sender.location(in: self.view)
        let actualCenterX = self.view.bounds.midX
        let actualCenterY = self.view.bounds.midY
        
        let deltaX = point.x - actualCenterX
        let deltaY = point.y - actualCenterY
        
        centerXLayout.constant = deltaX
        centerYLayout.constant = deltaY
        
        let duration : TimeInterval = 0.7 //seconds
        
        //safe approach - weak reference
        UIView.animate(withDuration: duration) { [weak self] in
            //self?.myView.center = point
            
            guard let strongSelf = self else { return }
            //strongSelf.myView.center = point
            strongSelf.view.layoutSubviews()
        }
        
        //unowned - a.k.a. "Trust me, I'm an engineer"
        /*
        UIView.animate(withDuration: duration) { [unowned self] in
            self.myView.center = point
        }
        */
        

        //walk-around
        /*
         let myView = self.myView
         UIView.animate(withDuration: duration) {
         myView?.center = point
         }

         */
        
        //memory issue - closure retain the view-controller while exist
        /*
         UIView.animate(withDuration: duration) {
         self.myView.center = point
         }*/
        
        //UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>)
        
        //myView.center = point
        
    }
    
}












