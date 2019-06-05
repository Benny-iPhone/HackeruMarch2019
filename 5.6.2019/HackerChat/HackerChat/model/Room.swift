//
//  Room.swift
//  HackerChat
//
//  Created by hackeru on 05/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import Firebase

struct Room{
    
    let owner : String //user id
    let createdAt : TimeInterval
    let name : String
    let roomId : String
    
    var dbRef : DatabaseReference{
        get{
            return Database.database().reference().child("rooms").child(roomId)
        }
    }
    
    init?(name : String){
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        self.name = name
        self.owner = uid
        self.createdAt = Date().timeIntervalSince1970
        self.roomId = UUID().uuidString
    }
    
    func storeData(){
        
        let json : [String:Any] = [
            "owner":owner,
            "createdAt":createdAt,
            "name":name,
            "roomId":roomId
        ]
        
        dbRef.setValue(json)
        
    }
    
    
}

