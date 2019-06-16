//
//  User+MessageKit.swift
//  HackerChat
//
//  Created by hackeru on 16/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import Firebase
import MessageKit


struct UserWrapper : SenderType{
    public var displayName: String
    public var senderId: String
}
/*

extension User : SenderType{
    
    public var senderId: String {
        return self.uid
    }
    
    public var displayName: String? {
        return self.displayName
    }
    
    
}

*/
