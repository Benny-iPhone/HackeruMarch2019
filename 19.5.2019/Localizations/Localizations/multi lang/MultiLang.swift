//
//  MultiLang.swift
//  Localizations
//
//  Created by hackeru on 19/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation

func isRTL() -> Bool{
    
    return Locale.characterDirection(forLanguage: Locale.current.languageCode!) == .rightToLeft
    
}

extension String{
    var translated : String{
        get{
            return NSLocalizedString(self, comment: self)
        }
    }
}

