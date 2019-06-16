//
//  RegisterViewController.swift
//  HackerChat
//
//  Created by hackeru on 05/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwrodTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        //Validate data
        guard let email = emailTextField.text, !email.isEmpty else{
            HUD.flash(.label("Email is missing"), delay: 1)
            return
        }
        
        guard let password = passwrodTextField.text, !password.isEmpty else{
            HUD.flash(.label("Password is missing"), delay: 1)
            return
        }
        
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else {
            HUD.flash(.label("nickname is missing"), delay: 1)
            return
        }
        
        //Sign up using FirebaseAuth
        
        HUD.show(.progress)
        sender.isEnabled = false
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                let text = error?.localizedDescription ?? "Unknown Error"
                HUD.flash(.labeledError(title: "Sign Up Error", subtitle: text), delay: 3)
                sender.isEnabled = true
                return
            }
            
            //Sign up Finished, update nickname
            
            let request = result.user.createProfileChangeRequest()
            request.displayName = nickname
            request.commitChanges(completion: { (updateError) in
                
                sender.isEnabled = true
                
                if let updateError = updateError{
                    let text = updateError.localizedDescription
                    HUD.flash(.labeledError(title: "Sign Up Error", subtitle: text), delay: 1)
                } else {
                    Router.shared.determineRoot()
                }
            })
        }
        
    }
    

}








