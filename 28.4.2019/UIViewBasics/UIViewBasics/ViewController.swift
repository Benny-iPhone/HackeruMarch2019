//
//  ViewController.swift
//  UIViewBasics
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var subView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createASubView()
        print(self.view.frame)
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = .purple
    }*/
    
    
    //when constraints took place
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        adjustSubViewPosition(subview: self.subView)
    }
    
    private func adjustSubViewPosition(subview : UIView){
        //let x = self.view.frame.origin.x + self.view.frame.width * 0.5
        let centerPoint = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        subview.center = centerPoint
    }
    
    private func createASubView(){
        let rect = CGRect(x: 100, y: 100, width: 200, height: 200)
        let subView = UIView(frame: rect)
        
        subView.backgroundColor = UIColor.blue
        
        self.view.addSubview(subView)
        //self.subview is a weak reference, therefore we set the value after setting a strong reference (by adding the object as a subview)
        //a command like self.subView = UIView(...
        //is not recommended, the ARC will release the object due to a lack of strong reference.
        self.subView = subView
        
        let yellowView = UIView(frame: CGRect(x: 30, y: 30, width: 80, height: 80))
        yellowView.backgroundColor = .yellow
        subView.addSubview(yellowView)
        
        subView.addSubview(GreenView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        
        adjustSubViewPosition(subview: subView)
    }


}

