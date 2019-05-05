//
//  ViewController.swift
//  ViewBasics2
//
//  Created by hackeru on 05/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupBorderFor(aView: greenView)
        createView()
        createAutoLayoutSubView()
    }
    
    private func createAutoLayoutSubView(){
        let button = UIButton(type: .system)
        button.setTitle("Click Me", for: UIControl.State.normal)
        button.tintColor = .orange
        //disable auto sizing to avoid confilcts with coming constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        //short way
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48).isActive = true
        
        //button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
        //long way
        /*
        self.view.addConstraints([
            //x: 8 from left side
            NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 8),
            //y: 40 from top
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 40)
            ])
 */
    }
    
    private func createView(){
        //create subview
        let rect = CGRect(x: 40, y: 140, width: 250, height: 100)
        let subView = UIView(frame: rect)
        subView.backgroundColor = .blue
        
        //limit subview to be in parent-view bounds
        subView.clipsToBounds = true
        
        //add label
        
        let label = UILabel(frame: CGRect.zero) //x:0 y:0 w:0 h:0
        label.text = "Label From Code 👶🏻👶🏻"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        //adjust width and height for text dims
        label.sizeToFit()
        //center the label
        label.center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        subView.addSubview(label)
        
        //add to main view
        self.view.addSubview(subView)
        setupBorderFor(aView: subView)
    }
    
    private func setupBorderFor(aView : UIView){
        aView.layer.borderWidth = 2
        aView.layer.borderColor = UIColor.purple.cgColor
    }


}

