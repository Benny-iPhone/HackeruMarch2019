//
//  ViewController.swift
//  UViewProperties
//
//  Created by hackeru on 05/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var blackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction(_:))))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func tapAction(_ sender : Any){
        print(#function)
    }

    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        mapView.alpha = CGFloat(sender.value)
        //blackView.alpha = CGFloat(sender.value)
        blackView.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(sender.value))
        
    }
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        label.isHidden = sender.isOn == false
        /*
        if sender.isOn{
            label.isHidden = false
        } else {
            label.isHidden = true
        }
 */
    }
    
    @IBOutlet weak var buttonContainerView: UIView!
    @IBAction func buttonAction(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func userInteractionSwitchAction(_ sender: UISwitch) {
        //buttonContainerView.isUserInteractionEnabled = sender.isOn
        guard let relevantView = self.view.viewWithTag(1) else{
            //view with tag 1 not found
            return
        }
        
        relevantView.isUserInteractionEnabled = sender.isOn
        
    }
    
}






















