//
//  TweetTextCell.swift
//  CellFromNibFile
//
//  Created by hackeru on 10/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TweetTextCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func populate(with tweet : Tweet){
        
        contentLabel.text = tweet.content
        userLabel.text = "By @" + tweet.author
        
    }
    
}
