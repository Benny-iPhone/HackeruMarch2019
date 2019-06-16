//
//  LoginViewController.swift
//  HackerChat
//
//  Created by hackeru on 05/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        
        //Validate data
        guard let email = emailTextField.text, !email.isEmpty else{
            HUD.flash(.label("Email is missing"), delay: 1)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else{
            HUD.flash(.label("Password is missing"), delay: 1)
            return
        }
        
        //Sign in using Firebase' Auth
        
        HUD.show(.labeledProgress(title: "Signing In...", subtitle: nil))
        sender.isEnabled = false
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            sender.isEnabled = true

            guard let _ = result else {
                let text = error?.localizedDescription ?? "Unknown Error"
                HUD.flash(.labeledError(title: "Sign In Error", subtitle: text), delay: 3)
                return
            }
            
            Router.shared.determineRoot()
        }
    }
    
}
