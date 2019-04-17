//
//  BackgroundView.swift
//  GradientProject
//
//  Created by hackeru on 17/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

//https://stackoverflow.com/questions/50037160/swift-background-gradient-for-uiview

class BackgroundView: UIView {

    //init from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //self.backgroundColor = .red
        setupGradientLayer()
    }
    
    weak var gradientLayer : CAGradientLayer?
    
    private func setupGradientLayer(){
        let gLayer = CAGradientLayer()
        gLayer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor,UIColor.green.cgColor]
        gLayer.frame = self.bounds
        //print(self.bounds)
        gLayer.startPoint = CGPoint(x: 0, y: 1)
        gLayer.endPoint = CGPoint(x: 1, y: 0)
        
        self.layer.addSublayer(gLayer)
        self.gradientLayer = gLayer
        
    }
    
    //constraints updated
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradientLayer?.frame = self.bounds
    }

}








