//
//  ChatRoom.swift
//  HackerChat
//
//  Created by hackeru on 12/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

struct ChatRoom{
    
    var messagesDatabaseReference : DatabaseReference{
        return Database.database().reference().child("msgs").child(self.id)
    }
    
    static var chatRoomsRef : DatabaseReference{
        return Database.database().reference().child("chat_rooms")
    }
    
    let id : String
    let name : String
    let owner : String
    let description : String?
    var imageName : String?
    
    var imageStorageRef : StorageReference?{
        guard let imageName = self.imageName else { return nil}
        return Storage.storage().reference().child("chatrooms").child(imageName)
    }
    
    init?(dict : [String:Any]){
        guard let id = dict["id"] as? String,
            let name = dict["name"] as? String,
            let owner = dict["owner"] as? String else{
                return nil
        }
        
        self.id = id; self.name = name; self.owner = owner
        self.description = dict["description"] as? String
        self.imageName = dict["image_name"] as? String
    }
    
    init(name : String, uid : String, description : String? = nil){
        self.name = name
        self.owner = uid
        self.id = UUID().uuidString
        self.description = description
        self.imageName = nil
    }
    
    func save(){
        var dict : [String:Any] = [
            "name":name,
            "owner":owner,
            "id":id
        ]
        
        if let description = self.description{
            dict["description"] = description
        }
        
        if let imageName = self.imageName{
            dict["image_name"] = imageName
        }
        
        let node = ChatRoom.chatRoomsRef.child(id)
        node.setValue(dict)
        
    }
    //                                                (filename,uploadError)->Void
    func upload(image : UIImage, callback : @escaping (String,Error?)->Void)
    {
        guard let data = image.jpegData(compressionQuality: 0.7) else { return }
        
        let filename = UUID().uuidString + ".jpeg"
        
        let ref = Storage.storage().reference().child("chatrooms").child(filename)
        
        ref.putData(data, metadata: nil) { (_, error) in
            if let error = error{
                callback(filename,error)
                return
            }
            
            callback(filename,nil)
        }
        
        
    }
    
    func removeFromDB(){
        //clean up files
        if let storageRef = self.imageStorageRef{
            storageRef.delete(completion: nil)
        }
        
        //remove data
        ChatRoom.chatRoomsRef.child(self.id).setValue(nil)
    }
}
