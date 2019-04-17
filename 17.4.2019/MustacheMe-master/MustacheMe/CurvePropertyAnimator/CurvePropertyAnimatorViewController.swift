//
//  CurvePropertyAnimatorViewController.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

class CurvePropertyAnimatorViewController: UIViewController {

    // MARK: - Properties
    
    private let animatedView = UIView()
    private let margin: CGFloat = 70
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: CurvePropertyAnimatorViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .screen
        
        view.addSubview(animatedView)
        let edge: CGFloat = 60
        animatedView.backgroundColor = .warmPink
        animatedView.clipsToBounds = true
        animatedView.layer.cornerRadius = edge * 0.5
        animatedView.frame = CGRect(x: edge * 0.5 + margin, y: UIScreen.main.bounds.midY, width: edge, height: edge)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateWithControlPoints()
    }
    
    private func animateWithControlPoints() {
        let destination = CGPoint(x: view.bounds.maxX - animatedView.bounds.width * 0.5 - margin, y: animatedView.frame.midY)
        
        let controlPoint1 = CGPoint(x: 0.44, y: 0.06)
        let controlPoint2 = CGPoint(x: 0.93, y: 0.6)
        
        let animator = UIViewPropertyAnimator(duration: 5,
                                              controlPoint1: controlPoint1,
                                              controlPoint2: controlPoint2)
        animator.addAnimations {
            self.animatedView.center = destination
        }
        animator.startAnimation()
    }
}
