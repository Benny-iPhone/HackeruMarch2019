//
//  MultipleAnimationsViewController.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

infix operator ~>: AdditionPrecedence

class MultipleAnimationsViewController: UIViewController {

    enum Method: Int {
        case calayer
        case uiview
        case propertyAnimator
    }
    
    // MARK: - Properties
    
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    private var view1: UIView!
    private var view2: UIView!
    private var view3: UIView!
    private var view4: UIView!
    
    private let originX: CGFloat = 50
    private let width: CGFloat = 100
    
    private var destinationX: CGFloat {
        return view.bounds.width - width * 0.5 - originX
    }
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: MultipleAnimationsViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .screen
        prepareLayout()
    }
    
    // MARK: - Setup
    
    private func prepareLayout() {
        func generateView(color: UIColor, yPosition: CGFloat, text: String) -> UIView {
            let animatedView = UIView()
            view.addSubview(animatedView)
            animatedView.backgroundColor = color
            animatedView.frame = CGRect(x: originX, y: yPosition, width: 100, height: 70)
            let label = UILabel()
            label.textAlignment = .center
            label.text = text
            label.frame = animatedView.bounds
            animatedView.addSubview(label)
            return animatedView
        }
        
        [view1, view2, view3, view4].forEach { $0?.removeFromSuperview() }
        view1 = generateView(color: UIColor(rgb: 0xfe4a49), yPosition: 220, text: "view1")
        view2 = generateView(color: UIColor(rgb: 0x2ab7ca), yPosition: view1.frame.maxY + 10, text: "view2")
        view3 = generateView(color: UIColor(rgb: 0xfed766), yPosition: view2.frame.maxY + 10, text: "view3")
        view4 = generateView(color: UIColor(rgb: 0xe6e6ea), yPosition: view3.frame.maxY + 10, text: "view4")
    }
    
    // MARK: - User Actions
    
    @IBAction private func segmentedControlValueChanged(segmentedControl: UISegmentedControl) {
        prepareLayout()
        
        let method = Method(rawValue: segmentedControl.selectedSegmentIndex)!
        switch method {
        case .calayer:
            setupAnimationUsingCoreAnimation()
        case .uiview:
            setupAnimationUsingStaticFunctions()
        case .propertyAnimator:
            setupAnimationUsingPropertyAnimatorPretty2()
        }
    }
    
    // MARK: - Property Animator method
    
    private func setupAnimationUsingPropertyAnimator() {
        
        let view1Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view1.center.x = self.destinationX
        }
        
        let view2Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view2.center.x = self.destinationX
            self.view1.alpha = 0
        }
        
        let view3Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view3.center.x = self.destinationX
            self.view2.alpha = 0
        }
        
        let view4Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view4.center.x = self.destinationX
            self.view3.alpha = 0
        }
        
        let lastAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view4.alpha = 0
        }
        
        view1Animator.addCompletion { _ in
            view2Animator.startAnimation()
        }
        
        view2Animator.addCompletion { _ in
            view3Animator.startAnimation()
        }
        
        view3Animator.addCompletion { _ in
            view4Animator.startAnimation()
        }
        
        view4Animator.addCompletion { _ in
            lastAnimator.startAnimation()
        }
        
        view1Animator.startAnimation()
    }
    
    private func setupAnimationUsingPropertyAnimatorPretty() {
        let view1Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view1.center.x = self.destinationX
        }
        
        let view2Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view2.center.x = self.destinationX
            self.view1.alpha = 0
        }
        
        let view3Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view3.center.x = self.destinationX
            self.view2.alpha = 0
        }
        
        let view4Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view4.center.x = self.destinationX
            self.view3.alpha = 0
        }
        
        let lastAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view4.alpha = 0
        }
        
        // Create dependency in a readable manner
        view1Animator.then(view2Animator).then(view3Animator).then(view4Animator).then(lastAnimator)
        view1Animator.startAnimation()
    }
    
    private func setupAnimationUsingPropertyAnimatorPretty2() {

        let view1Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view1.center.x = self.destinationX
        }
        
        let view2Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view2.center.x = self.destinationX
            self.view1.alpha = 0
        }
        
        let view3Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view3.center.x = self.destinationX
            self.view2.alpha = 0
        }
        
        let view4Animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view4.center.x = self.destinationX
            self.view3.alpha = 0
        }
        
        let lastAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.view4.alpha = 0
        }
        
        // Create dependency in a readable manner
        view1Animator ~> view2Animator ~> view3Animator ~> view4Animator ~> lastAnimator
        
        view1Animator.startAnimation()
    }
    
    // MARK: - UIView method
    
    private func setupAnimationUsingStaticFunctions() {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.view1.center.x = self.destinationX
        }) { finished in
            guard finished else {
                return
            }
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                self.view2.center.x = self.destinationX
                self.view1.alpha = 0
            }) { finished in
                guard finished else {
                    return
                }
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                    self.view3.center.x = self.destinationX
                    self.view2.alpha = 0
                }) { finished in
                    guard finished else {
                        return
                    }
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                        self.view4.center.x = self.destinationX
                        self.view3.alpha = 0
                    }) { finished in
                        guard finished else {
                            return
                        }
                        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
                            self.view4.alpha = 0
                        }, completion: nil)
                    }
                }
            }
        }
    }
    
    // MARK: - Core Animation method (CALayer)
    
    private func setupAnimationUsingCoreAnimation() {
        
        func fadeOut(beginTime: CFTimeInterval) -> CABasicAnimation {
            let fadeOut = CABasicAnimation(keyPath: "opacity")
            fadeOut.fromValue = NSNumber(value: 1)
            fadeOut.toValue = NSNumber(value: 0)
            fadeOut.timingFunction = CAMediaTimingFunction(name: .easeOut)
            fadeOut.beginTime = beginTime
            fadeOut.isRemovedOnCompletion = false
            fadeOut.fillMode = .forwards
            fadeOut.duration = 1
            return fadeOut
        }
        
        func translation(from origin: CGPoint, to destination: CGPoint, beginTime: CFTimeInterval) -> CABasicAnimation {
            let translation = CABasicAnimation(keyPath: "position")
            translation.fromValue = NSValue(cgPoint: origin)
            translation.toValue = NSValue(cgPoint: destination)
            translation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            translation.beginTime = beginTime
            translation.isRemovedOnCompletion = false
            translation.fillMode = .forwards
            translation.duration = 1
            return translation
        }
        
        func group(animations: [CABasicAnimation], duration: CFTimeInterval) -> CAAnimationGroup {
            let group = CAAnimationGroup()
            group.duration = duration
            group.beginTime = 0
            group.isRemovedOnCompletion = false
            group.fillMode = .forwards
            group.animations = animations
            return group
        }
        
        func animate(view: UIView, beginTime: CFTimeInterval, duration: CFTimeInterval) {
            let origin = view.layer.position
            let destination = CGPoint(x: destinationX, y: view.center.y)
            let translationAnimation = translation(from: origin, to: destination, beginTime: beginTime)
            let fadeOutAnimation = fadeOut(beginTime: beginTime + 1)
            let groupAnimation = group(animations: [translationAnimation, fadeOutAnimation], duration: duration)
            view.layer.add(groupAnimation, forKey: nil)
        }
        
        animate(view: view1, beginTime: 0, duration: 2)
        animate(view: view2, beginTime: 1, duration: 3)
        animate(view: view3, beginTime: 2, duration: 4)
        animate(view: view4, beginTime: 3, duration: 5)
    }
}
