//
//  ScrubbedPropertyAnimatorViewController.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

class ScrubbedPropertyAnimatorViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var slider: UISlider!
    
    private var animatedView = UIView()
    private var fractionLabel = UILabel()
    
    private var widthConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    private var animator: UIViewPropertyAnimator!
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: ScrubbedPropertyAnimatorViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .screen
        
        animatedView.clipsToBounds = true
        animatedView.backgroundColor = UIColor(red: 233, green: 181, blue: 56)
        view.addSubview(animatedView)
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        animatedView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animatedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        widthConstraint = animatedView.widthAnchor.constraint(equalToConstant: 80)
        widthConstraint.isActive = true
        heightConstraint = animatedView.heightAnchor.constraint(equalToConstant: 160)
        heightConstraint.isActive = true
        
        fractionLabel = UILabel()
        fractionLabel.translatesAutoresizingMaskIntoConstraints = false
        fractionLabel.textColor = .white
        fractionLabel.textAlignment = .center
        animatedView.addSubview(fractionLabel)
        fractionLabel.centerXAnchor.constraint(equalTo: animatedView.centerXAnchor).isActive = true
        fractionLabel.centerYAnchor.constraint(equalTo: animatedView.centerYAnchor).isActive = true
        
        view.layoutIfNeeded()
        
        let endPositionEdgeLength: CGFloat = 80
        let rotationAngle: CGFloat = .pi * 0.5
        
        // Initialize the property animator
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        
        // Add animation closure
        animator.addAnimations {
            
            // Change background color
            self.animatedView.backgroundColor = .warmPink
            
            // Rotate the animated view by a constant radian value
            self.animatedView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            // Swap the width and height values
            self.widthConstraint.constant = endPositionEdgeLength
            self.heightConstraint.constant = endPositionEdgeLength
            
            // Set corder radius to half the minimal edge
            self.animatedView.layer.cornerRadius = endPositionEdgeLength * 0.5
            
            // Rotate the label in the opposite direction to maintain its position
            self.fractionLabel.transform = CGAffineTransform(rotationAngle: -rotationAngle)
            
            // Tell the view to layout again
            self.view.layoutIfNeeded()
        }
        
        // The animator is in .inactive state until pauseAnimations() is being invoked
        animator.pauseAnimation()
        fractionLabel.text = String(format: "%.2f", animator.fractionComplete)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        animator?.stopAnimation(true)
    }
    
    @IBAction private func sliderValueChanged(_ slider: UISlider) {
        animator.fractionComplete = CGFloat(slider.value)
        fractionLabel.text = String(format: "%.2f", animator.fractionComplete)
    }
}
