//
//  ChatMessage.swift
//  HackerChat
//
//  Created by hackeru on 16/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import Firebase

struct ChatMessage{
    
    enum `Type` : String{
        case text
        case image
        //case location
    }
    
    let type : Type
    let mid : String //message id
    let uid : String //author id
    let uName : String //author name
    var text : String? //text if exist, or storage ref
    let date : Date //create date, stored as timestamp
    
    init?(json : [String:Any]){
        guard let mid = json["mid"] as? String,
            let uid = json["uid"] as? String,
            let uName = json["uName"] as? String,
            let dateRaw = json["date"] as? TimeInterval else{
                return nil
        }
        
        self.mid = mid
        self.uid = uid
        self.uName = uName
        self.date = Date(timeIntervalSince1970: dateRaw)
        self.text = json["text"] as? String
        
        if let typeRaw = json["type"] as? String,
            let type = Type(rawValue: typeRaw){
            self.type = type
        } else {
            self.type = .text
        }
    }
    
    init(text : String){
        guard let user = Auth.auth().currentUser else { fatalError() }
        self.mid = UUID().uuidString
        self.uid = user.uid
        self.uName = user.displayName ?? ""
        self.text = text
        self.date = Date()
        self.type = .text
    }
    
    init(type : Type){
        guard let user = Auth.auth().currentUser else { fatalError() }
        
        self.mid = UUID().uuidString
        self.uid = user.uid
        self.uName = user.displayName ?? ""
        self.text = nil
        self.date = Date()
        self.type = type
    }
    
    var storageRef : StorageReference{
        get{
            return Storage.storage().reference().child("msg_images").child(text ?? "" )
        }
    }
    
    mutating func save(imageData data : Data, callback : @escaping (Error?)->Void){
        let filename = UUID().uuidString + ".jpeg"

        self.text = filename
        
        storageRef.putData(data, metadata: nil) { (_, err) in
            callback(err)
        }
        
    }
    
    func save(in room : ChatRoom){
        
        //msgs -> room_id -> message_id -> JSON
        //let dbRef = Database.database().reference().child("msgs").child(room.id).child(mid)
        let dbRef = room.messagesDatabaseReference.child(self.mid)
        
        var json : [String:Any] = [
            "mid":mid,
            "uid":uid,
            "uName":uName,
            "date":date.timeIntervalSince1970,
            "type":type.rawValue
        ]
        
        if let text = self.text{ json["text"] = text }
        
        dbRef.setValue(json)
        
    }

    
}
