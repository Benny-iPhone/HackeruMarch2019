//
//  MovieCell.swift
//  Movies
//
//  Created by hackeru on 26/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var imageView : UIImageView!

    
    func populate(with movie : MovieResponse.Movie)
    {
        label.text = movie.title
        let imageUrlString = "https://image.tmdb.org/t/p/original" + movie.poster_path
        let url = URL(string: imageUrlString)
        imageView.sd_setImage(with: url)
        
    }
    
}
