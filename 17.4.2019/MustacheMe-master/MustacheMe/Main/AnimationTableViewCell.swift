//
//  AnimationTableViewCell.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/25/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

struct AnimationTableViewCellData {
    typealias Action = () -> Void
    let name: String
    let action: Action
}

class AnimationTableViewCell: UITableViewCell {
    
    var title: String {
        set {
            textLabel?.text = newValue
        }
        get {
            return textLabel?.text ?? ""
        }
    }
}
