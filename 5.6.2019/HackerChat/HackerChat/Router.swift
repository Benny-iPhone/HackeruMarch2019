//
//  Router.swift
//  HackerChat
//
//  Created by hackeru on 05/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Firebase

class Router{
    static let shared = Router()
    
    weak var window : UIWindow?
    
    private var didLogin : Bool{
        return Auth.auth().currentUser != nil
    }
    
    func determineRoot(){
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                Router.shared.determineRoot()
            }
            return
        }
        
        let filename : String
        if didLogin{
            filename = "Main"
        } else {
            filename = "Login"
        }
        
        let storyboard = UIStoryboard(name: filename, bundle: .main)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        
    }
    
}
















