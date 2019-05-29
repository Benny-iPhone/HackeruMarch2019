//
//  Router.swift
//  LoginVCProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class Router{
    static let shared = Router()
    
    weak var window : UIWindow?
    
    func determineRoot(){
        if DataStore().didLogin{
            showMain()
        } else {
            showLogin()
        }
    }
    
    private func showLogin(){
        showStoryboard(name: "Login")
    }
    
    private func showMain(){
        showStoryboard(name: "AppFlow")
    }
    
    private func showStoryboard(name : String){
        
        guard Thread.isMainThread else{
            
            DispatchQueue.main.async { [unowned self] in
                self.showStoryboard(name: name)
            }
            return
        }
        
        let storyboard = UIStoryboard(name: name, bundle: .main)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        
    }
}
