//
//  ViewController.swift
//  HomeworkLoginPage
//
//  Created by hackeru on 03/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - LoginMethod -
    
    enum LoginMethod : Int{
        case email
        case phone
    }
    
    var currentLoginMethod : LoginMethod{
        get{
            let index = loginMethodSegmentedControl.selectedSegmentIndex
            //If you crashed here, perhaps you missed something in the enum def
            return LoginMethod(rawValue: index)!
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var loginMethodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var idTextField : UITextField!
    
    //MARK: - UI Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginMethodSegmentedControl.selectedSegmentIndex = LoginMethod.phone.rawValue
        refreshUIAccordingToLoginMethod()
    }
    
    private func refreshUIAccordingToLoginMethod(){
        switch currentLoginMethod {
        case .email:
            idTextField.placeholder = "Email"
            idTextField.keyboardType = .emailAddress
        case .phone:
            idTextField.placeholder = "Phone"
            idTextField.keyboardType = .phonePad
        }
        
        idTextField.text = ""
        
        //make sure that keyboard is open
        //make sure that idTextField is not nil, refer it non nil existence as textField
        guard let textField = idTextField, textField.isFirstResponder else{
            return
        }
        
        //close keyboard
        textField.resignFirstResponder()
        
        //after 0.3 seconds, re-open keyboard
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            textField.becomeFirstResponder()
        }
    }
    
    //MARK: - IBAction -

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        refreshUIAccordingToLoginMethod()
    }
    
}

