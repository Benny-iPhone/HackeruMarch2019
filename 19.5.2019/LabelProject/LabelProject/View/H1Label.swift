//
//  H1Label.swift
//  LabelProject
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class H1Label: UILabel {

    private func setup()
    {
        self.font = UIFont.systemFont(ofSize: 38)
        self.textColor = .blue
        self.backgroundColor = .lightGray
        self.shadowColor = .black
        self.shadowOffset = CGSize(width: 1, height: 1)
        self.numberOfLines = 0
        self.textAlignment = .center
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

}
