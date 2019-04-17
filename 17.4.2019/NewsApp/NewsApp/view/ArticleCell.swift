//
//  ArticleCell.swift
//  NewsApp
//
//  Created by hackeru on 17/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!

    func config(with obj : NewsAPI.Article)
    {
        
        titleLabel.text = obj.title
        descLabel.text = obj.description
        
        if let urlString = obj.urlToImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlString){
            articleImageView.sd_setImage(with: url)
        } else {
            articleImageView.sd_cancelCurrentImageLoad()
            articleImageView.image = nil
        }
        
    }
}
