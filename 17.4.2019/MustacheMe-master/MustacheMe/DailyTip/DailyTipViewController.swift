//
//  DailyTipViewController.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

class DailyTipViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let visualEffectView = UIVisualEffectView(effect: nil)
    private let dailyTipView = DailyTipView()
    
    private var inConstraint: NSLayoutConstraint!
    private var outConstraint: NSLayoutConstraint!
    private var leftConstraint: NSLayoutConstraint!
    private var rightConstraint: NSLayoutConstraint!
    
    private var translationAnimator: UIViewPropertyAnimator!
    
    private var isReversed: Bool {
        set {
            translationAnimator.isReversed = newValue
        }
        get {
            return translationAnimator.isReversed
        }
    }
    
    private var totalDistance: CGFloat {
        return dailyTipView.bounds.height - 70
    }
    
    var panBeginningProgress: CGFloat = 0
    
    private lazy var tips: [DailyTipData] = {
        var array: [DailyTipData] = []
        let combItData = DailyTipData(imageName: "mustache_1", subject: "Comb It", description: "When your mustache is long enough to comb, comb it once a day and create a part by combing the hair out from under the nose to the left and to the right respectively. This will train your ‘stache to grow out in the traditional handlebar fashion. A simple Tweezerman comb will do the trick. If you want to get fancy, go with a wooden mustache comb handmade by actor Nick Offerman, aka Ron Swanson.")
        let waxItData = DailyTipData(imageName: "mustache_2", subject: "Wax It", description: "After you get out of the shower, leave your mustache damp. Starting in the middle of your lip, apply a small dab of mustache wax with your fingertip to the upper edge and use a comb to spread it down through the hair. Work your way out to each end, applying more wax as needed. If your mustache is wiry, use more wax. Many handlebar owners suggest Clubman Mustache Wax.")
        let twistItData = DailyTipData(imageName: "mustache_3", subject: "Twist and Shape It", description: "To add that distinctive handlebar curl, apply some wax to the ends and twist the hairs together with your fingers. Then curl the twisted hair up and in. You can also create a curl by winding the ends as tightly as possible around a writing pen.")
        return [combItData, waxItData, twistItData]
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: DailyTipViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Freddie's Photos"
        
        let backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.backgroundColor = backgroundColor
        collectionView.backgroundColor = backgroundColor
        
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1
        
        setupCollectionView()
        setupVisualEffectView()
        setupDailyTipView()
        setupGestureRecognizers()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width * 0.5
    }
    
    // MARK: - Setup
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 1.0 / 3.0 - 3 - 2.0/3.0, height: UIScreen.main.bounds.width * 1.0 / 3.0 - 2 - 2.0/3.0)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: ImageCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.className)
    }
    
    private func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupDailyTipView() {
        view.addSubview(dailyTipView)
        dailyTipView.translatesAutoresizingMaskIntoConstraints = false
        
        inConstraint = dailyTipView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        inConstraint.priority = .defaultLow
        inConstraint.isActive = true
        
        outConstraint = dailyTipView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        outConstraint.priority = .defaultHigh
        outConstraint.isActive = true
        
        leftConstraint = dailyTipView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        leftConstraint.isActive = true
        
        rightConstraint = dailyTipView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        rightConstraint.isActive = true
        
        dailyTipView.data = tips.randomElement()
    }
    
    private func setupGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        dailyTipView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDailyTipViewTap(gr:)))
        dailyTipView.addGestureRecognizer(tapGestureRecognizer)
        
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(gr:)))
        visualEffectView.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    // MARK: - Gesture Recognizers
    
    @objc private func handleBackgroundTap(gr: UITapGestureRecognizer) {
        let isAnimatorRunning = translationAnimator?.isRunning ?? false
        switch dailyTipView.state {
        case .expanded where !isAnimatorRunning:
            animateOrReverse(state: dailyTipView.state.opposite)
        case .collapsed where isAnimatorRunning && !isReversed:
            animateOrReverse(state: dailyTipView.state.opposite)
        default:
            break
        }
    }
    
    @objc private func handleDailyTipViewTap(gr: UITapGestureRecognizer) {
        animateOrReverse(state: dailyTipView.state.opposite)
    }
    
    @objc private func handlePan(gr: UIPanGestureRecognizer) {
        switch gr.state {
        case .began:
            beginTranslation()
        case .changed:
            let translation = gr.translation(in: view).y
            changeTranslation(to: translation)
        case .cancelled, .failed, .ended:
            let velocity = gr.velocity(in: view).y
            finishTranslation(with: velocity)
        case .possible:
            break
        }
    }
    
    // MARK: - Animation Logic
    
    private func animateOrReverse(state: DailyTipView.State) {
        if translationAnimator != nil {
            isReversed = !isReversed
        } else {
            translate(to: state)
        }
    }
    
    private func beginTranslation() {
        translate(to: dailyTipView.state.opposite)
        translationAnimator.pauseAnimation()
        panBeginningProgress = translationAnimator.fractionComplete
    }
    
    private func changeTranslation(to translation: CGFloat) {
        var additionalProgress = translation / totalDistance
        if dailyTipView.state.isCollapsed { // Direction upwards
            additionalProgress *= -1
        }
        
        if isReversed {
            additionalProgress *= -1
        }
        
        translationAnimator.fractionComplete = panBeginningProgress + additionalProgress
    }
    
    private func finishTranslation(with velocity: CGFloat) {
        defer {
            translationAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
        
        guard abs(velocity) > 20 else {
            return
        }
        
        let shouldCollapse = velocity > 0
        
        switch dailyTipView.state {
        case .expanded where shouldCollapse == isReversed:
            isReversed = !isReversed
        case .collapsed where shouldCollapse != isReversed:
            isReversed = !isReversed
        default:
            break
        }
    }
    
    private func translate(to state: DailyTipView.State) {
        guard translationAnimator == nil else {
            return
        }
        
        translationAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1) {
            self.updateLayout(for: state)
        }
                
        // Assign a new `state` value upon completion
        translationAnimator.addCompletion { position in
            switch position {
            case .start:
                self.dailyTipView.state = state.opposite
            case .end:
                self.dailyTipView.state = state
            case .current:
                break
            }
            
            self.translationAnimator = nil
        }
        translationAnimator.startAnimation()
    }
    
    private func updateLayout(for state: DailyTipView.State) {
        dailyTipView.updateLayout(for: state)
        updateBlurEffect(for: state)
        updatePosition(for: state)
    }
    
    private func updatePosition(for state: DailyTipView.State) {
        switch state {
        case .collapsed:
            inConstraint.priority = .defaultLow
            outConstraint.priority = .defaultHigh
            leftConstraint.constant = 20
            rightConstraint.constant = -20
        case .expanded:
            inConstraint.priority = .defaultHigh
            outConstraint.priority = .defaultLow
            leftConstraint.constant = 0
            rightConstraint.constant = 0
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func updateBlurEffect(for state: DailyTipView.State) {
        switch state {
        case .collapsed:
            visualEffectView.effect = nil
        case .expanded:
            visualEffectView.effect = UIBlurEffect(style: .dark)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DailyTipViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.className, for: indexPath) as! ImageCollectionViewCell
        cell.image = UIImage(named: "queen-thumb-\(indexPath.row)")
        return cell
    }
}
