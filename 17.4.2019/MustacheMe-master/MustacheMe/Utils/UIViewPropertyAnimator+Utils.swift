//
//  UIViewPropertyAnimator.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

extension UIViewPropertyAnimator {
    @discardableResult
    func then(_ animator: UIViewPropertyAnimator) -> UIViewPropertyAnimator {
        addCompletion { position in
            animator.startAnimation()
        }
        return animator
    }
}

extension UIViewPropertyAnimator {
    @discardableResult
    static func ~>(left: UIViewPropertyAnimator,
                   right: UIViewPropertyAnimator) -> UIViewPropertyAnimator {
        return left.then(right)
    }
}
