//
//  LoginViewController.swift
//  LoginVCProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var bl = LoginVCBL() //bl = Business Logic
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 8
        loginButton.layer.masksToBounds = true
        
        refreshButtonEnabled()
    }
    
    private func refreshButtonEnabled(){
        loginButton.isEnabled = bl.isValid
    }
    
    @IBAction func textFieldEditingChangedAction(_ sender: UITextField) {
        
        switch sender {
        case emailTextField: bl.email = sender.text ?? ""
        case passwordTextField: bl.password = sender.text ?? ""
        default:
            break
        }
        
        refreshButtonEnabled()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        bl.login { [weak self](success) in
            if success{
                var store = DataStore()
                store.authToken = "some auth token goes here"
                
                Router.shared.determineRoot()
                return
            }
            
            let alert = UIAlertController(title: "Login Failed", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
