//
//  ViewController.swift
//  ChessViewProject
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chesssView: ChessView!
    
    @IBOutlet weak var stepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .lightGray
        
        //createChessView()
        stepper.value = Double(chesssView.length)
        
        //for Mila - how to progromatically create stepper
        let myStepper = UIStepper(frame: CGRect.zero)
        myStepper.center = self.view.center
        myStepper.tintColor = .red
        myStepper.addTarget(self, action: #selector(stpperAction(_:)), for: .valueChanged)
        
        self.view.addSubview(myStepper)
    }
    
    @IBAction func stpperAction(_ sender: UIStepper) {
        chesssView.length = UInt(sender.value)
    }
    
    
    private func createChessView(){
        var rect = self.view.bounds
        rect.origin.x = 60
        rect.origin.y = 60
        rect.size.width -= 120
        rect.size.height -= 120
        let chessView = ChessView(frame: rect)
        self.view.addSubview(chessView)
    }


}

