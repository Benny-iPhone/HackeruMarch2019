//
//  ViewController.swift
//  ChangeColorBySegment
//
//  Created by hackeru on 31/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Color : Int{
        case black
        case red
        case green
        case blue
        case cyan
        
        var uiColor : UIColor{
            get{
                switch self{
                case .black: return .black
                case .red: return UIColor.red
                case .green: return UIColor.green
                case .blue: return UIColor.blue
                case .cyan: return UIColor.cyan
                }
            }
        }
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        UIView.animate(withDuration: 0.8) { [unowned self] in //avoid retain cycle
            self.view.backgroundColor = Color(rawValue: index)?.uiColor
        }
        
        /*
        if let color = Color(rawValue: sender.selectedSegmentIndex){
            switch color{
            case .black:
                self.view.backgroundColor = .black
            case .red:
                self.view.backgroundColor = .red
            }
        }
        */
        //print(sender.selectedSegmentIndex)
        
        
        
        //self.view.backgroundColor = .purple
        
    }
    

}

