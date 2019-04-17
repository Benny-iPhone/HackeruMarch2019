//
//  DailyTipView.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

struct DailyTipData {
    let imageName: String
    let subject: String
    let description: String
}

class DailyTipView: ViewFromNib {

    // MARK: - Types
    
    enum State {
        case collapsed
        case expanded
        
        var isCollapsed: Bool {
            return self == .collapsed
        }
        
        var opposite: State {
            switch self {
            case .collapsed:
                return .expanded
            case .expanded:
                return .collapsed
            }
        }
        
        mutating func flip() {
            self = opposite
        }
    }
    
    var state = State.collapsed
    
    // MARK: - Properties

    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelHorizontalCollapsedConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelHorizontalExpandedConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHorizontalExpandedConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHorizontalCollapsedConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewVerticalExpandedConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewVerticalCollapsedConstraint: NSLayoutConstraint!
        
    @IBOutlet private weak var collapsedTitleLabel: UILabel!
    @IBOutlet private weak var expandedTitleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var data: DailyTipData! {
        didSet {
            imageName = data.imageName
            subjectText = data.subject
            descriptionText = data.description
        }
    }
    
    private var imageName = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    private var subjectText: String {
        set {
            subjectLabel.text = newValue
        }
        get {
            return subjectLabel.text ?? ""
        }
    }
    
    private var descriptionText: String {
        set {
            descriptionLabel.text = newValue
        }
        get {
            return descriptionLabel.text ?? ""
        }
    }
    
    // MARK: - Setup
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        initNib()
        backgroundColor = .white
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        updateRoundCorners(for: state)
        updateSubjectAndDescription(for: state)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.width * 0.5
    }
    
    // MARK: - Updates
    
    func updateImageViewPosition(for state: State) {
        switch state {
        case .collapsed:
            imageViewWidthConstraint.constant = 45
            imageViewHorizontalCollapsedConstraint.priority = .defaultHigh
            imageViewHorizontalExpandedConstraint.priority = .defaultLow
            imageViewVerticalExpandedConstraint.priority = .defaultLow
            imageViewVerticalCollapsedConstraint.priority = .defaultHigh
        case .expanded:
            imageViewWidthConstraint.constant = 90
            imageViewHorizontalCollapsedConstraint.priority = .defaultLow
            imageViewHorizontalExpandedConstraint.priority = .defaultHigh
            imageViewVerticalExpandedConstraint.priority = .defaultHigh
            imageViewVerticalCollapsedConstraint.priority = .defaultLow
        }
    }
    
    func updateTitleLabel(for state: State) {
        let transform: CGAffineTransform
        switch state {
        case .collapsed:
            transform = .identity
            expandedTitleLabel.alpha = 0
            collapsedTitleLabel.alpha = 1
            titleLabelTopConstraint.constant = 22
            titleLabelHorizontalCollapsedConstraint.priority = .defaultHigh
            titleLabelHorizontalExpandedConstraint.priority = .defaultLow
        case .expanded:
            transform = .init(scaleX: 1.2, y: 1.2)
            expandedTitleLabel.alpha = 1
            collapsedTitleLabel.alpha = 0
            titleLabelTopConstraint.constant = 40
            titleLabelHorizontalCollapsedConstraint.priority = .defaultLow
            titleLabelHorizontalExpandedConstraint.priority = .defaultHigh
        }
        collapsedTitleLabel.transform = transform
        expandedTitleLabel.transform = transform
    }
    
    func updateSubjectAndDescription(for state: State) {
        let translation: CGAffineTransform
        switch state {
        case .collapsed:
            translation = .init(translationX: 20, y: 0)
            subjectLabel.alpha = 0
            descriptionLabel.alpha = 0
        case .expanded:
            translation = .identity
            subjectLabel.alpha = 1
            descriptionLabel.alpha = 1
        }
        subjectLabel.transform = translation
        descriptionLabel.transform = translation
    }
    
    func updateRoundCorners(for state: State) {
        switch state {
        case .collapsed:
            layer.cornerRadius = 30
        case .expanded:
            layer.cornerRadius = 0
        }
    }
    
    func updateLayout(for state: State) {
        updateTitleLabel(for: state)
        updateSubjectAndDescription(for: state)
        updateImageViewPosition(for: state)
        updateRoundCorners(for: state)
    }
}
