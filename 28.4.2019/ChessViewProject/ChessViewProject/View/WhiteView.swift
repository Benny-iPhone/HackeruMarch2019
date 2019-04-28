//
//  WhiteView.swift
//  ChessViewProject
//
//  Created by hackeru on 28/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class WhiteView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        self.backgroundColor = .white
    }

}










