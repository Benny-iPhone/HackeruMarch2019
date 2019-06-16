//
//  MainViewController.swift
//  HackerChat
//
//  Created by hackeru on 05/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class MainViewController: UIViewController {

    @IBOutlet weak var textField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var interval : TimeInterval = 3
        
        ["HackerU","Ramat Gan","iOS","Server","QA"].compactMap{ Room(name:$0) }.forEach { (room) in
            DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: {
                room.storeData()
            })
            
            interval += 3
        }
        
        
    }
    
    @IBAction func createDataPerUser(_ sender : Any){
        guard let text = textField.text, !text.isEmpty else{ return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let rootRef = Database.database().reference()
        
        let itemsRef = rootRef.child(uid).child("items")
        
        var newItem : [String:Any] = [
            "uid":uid,
            "text":text,
            "date":Date().timeIntervalSince1970
        ]
        
        if let name = Auth.auth().currentUser?.displayName{
            newItem["author"] = name
        }
        
        itemsRef.childByAutoId().setValue(newItem)
        
    }
    
    @IBAction func createData(_ sender : Any){
        guard let text = textField.text, !text.isEmpty else{ return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let rootRef = Database.database().reference()
        
        let itemsRef = rootRef.child("items")
        
        var newItem : [String:Any] = [
            "uid":uid,
            "text":text,
            "date":Date().timeIntervalSince1970
        ]
        
        if let name = Auth.auth().currentUser?.displayName{
            newItem["author"] = name
        }
        
        itemsRef.childByAutoId().setValue(newItem)
        
    }
    
    @IBAction func signOutAction(_ sender : Any){
        do{
            try Auth.auth().signOut()
            Router.shared.determineRoot()
        } catch {
            HUD.flash(.labeledError(title: error.localizedDescription, subtitle: nil), delay: 1.5)
        }
    }

}
