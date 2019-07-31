//
//  CardViewController.swift
//  PeekingCard
//
//  Created by Benny Davidovitz on 31/07/2019.
//  Copyright © 2019 HackerU. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    var card : Card!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet var collapsedLayouts: [NSLayoutConstraint]!
    
    var relatedLayouts : [NSLayoutConstraint]{
        var parentViewConstraints = self.view.superview?.constraints ?? []
        parentViewConstraints = parentViewConstraints.filter { c in
            if let firstItem = c.firstItem as? UIView, firstItem.isEqual(self.view){
                return true
            }
            if let secondItem = c.secondItem as? UIView, secondItem.isEqual(self.view){
                return true
            }
            
            return false
        }
        
        return parentViewConstraints
    }
    
    var topLayout : NSLayoutConstraint?{
        return self.relatedLayouts.first{ $0.firstAttribute == .top}
    }
    
    var totalHeight : CGFloat{
        return UIScreen.main.bounds.height - 180
    }
    
    enum DisplayMode{
        case collapse
        case expand
        
        var nextMode : DisplayMode{
            switch self {
            case .collapse: return .expand
            case .expand: return .collapse
            }
        }
        
        var cornerRadius : CGFloat{
            switch self {
            case .collapse: return 16
            case .expand: return 4
            }
        }
        
        var topLayoutConst : CGFloat{
            switch self {
            case .collapse: return -48
            case .expand: return -(UIScreen.main.bounds.height - 180)
            }
        }
    }
    
    var mode : DisplayMode = .collapse
    var animator : UIViewPropertyAnimator?
    
    private func animator(by mode : DisplayMode) -> UIViewPropertyAnimator{
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1)
        let topLayout = self.topLayout
        animator.addAnimations { [weak self] in
            guard let self = self else { return }
            self.view.layer.cornerRadius = mode.cornerRadius
            topLayout?.constant = mode.topLayoutConst
            
            self.view.superview?.layoutSubviews()
        }
        
        animator.addCompletion({ (_) in
            self.animator = nil
            self.mode = mode
        })
        
        return animator
    }
    
    private func change(to mode : DisplayMode){
//        if let animator = self.animator, animator.isRunning{
//            animator.stopAnimation(false)
//        }
        
        
        self.animator = animator(by: mode)
        
        
        animator?.startAnimation()
        
        
    }
    
    static func createVC() -> CardViewController{
        
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //mock card
        self.card = Card(title: "Pirate Bay", description: "Arrr me hearties! Make traditional Latin walk the plank and opt for pirate lorem ipsum for your next high seas design adventure", imageName: "ship")
        //populate UI
        populate(with: self.card)

        setupUI()
    }
    
    private func setupUI(){
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = mode.cornerRadius
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction(_:))))
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panAction(_:))))
    }
    
    private func populate(with card : Card){
        titleLabel.text = card.title
        descriptionLabel.text = card.description
        imageView.image = UIImage(named: card.imageName)

    }
    
    @objc func panAction(_ sender : UIPanGestureRecognizer){
        
        
        switch sender.state {
        case .began:
            //setup animator
            self.animator = animator(by: self.mode.nextMode)
            self.animator?.pauseAnimation()
        case .changed:
            //update progress
            let y = sender.translation(in: self.view).y
            self.animator?.fractionComplete = abs(y) / totalHeight
        case .cancelled, .failed, .ended:
            //finish animation
            animator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
    
    @objc func tapAction(_ sender : Any){
        self.change(to: self.mode.nextMode)
    }

    


}
