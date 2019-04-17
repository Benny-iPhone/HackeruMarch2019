//
//  ImageCollectionViewCell.swift
//  MustacheMe
//
//  Created by Daniel Huri on 12/26/18.
//  Copyright © 2018 Daniel Huri. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var image: UIImage! {
        set {
            imageView.image = newValue
        }
        get {
            return imageView.image
        }
    }
    
    // MARK: - Setup
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image = nil
    }
}
