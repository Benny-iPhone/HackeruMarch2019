//
//  ViewController.swift
//  FormProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollViewBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var middleNameTextField: UITextField!
    
    var requireMiddleName : Bool{
        get{
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //open keyboard for first name
        firstNameTextField.becomeFirstResponder()
        
        if !requireMiddleName{
            //middleNameTextField.removeFromSuperview()
            middleNameTextField.isHidden = true
        }
        
        hookAllTextFields()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboard(notification : Notification){
        guard let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{
                return
        }
        
        let screenHeight = UIScreen.main.bounds.height
        let delta = screenHeight - keyboardFrameValue.cgRectValue.origin.y
        scrollViewBottomLayout.constant = delta
        
//        if notification.name == UIResponder.keyboardWillHideNotification{
//            scrollViewBottomLayout.constant = 0
//        } else {
//            scrollViewBottomLayout.constant = keyboardFrameValue.cgRectValue.height
//        }
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.view.layoutSubviews()
        }
        
    }
    
    private func hookAllTextFields(){
        let textFields = stackView.arrangedSubviews.compactMap{ $0 as? UITextField}
        textFields.forEach{
            $0.addTarget(self, action: #selector(textFieldDidEndOnExitAction(_:)), for: .editingDidEndOnExit)
        }
    }

    @IBAction func closeKeyboardAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
    }
    
    //'Return Key' Pressed
    @IBAction func textFieldDidEndOnExitAction(_ sender: UITextField) {
        //find text-fields in stackview
        var textFields = stackView.arrangedSubviews.compactMap{ $0 as? UITextField}
        
        //ignore hidden fields
        textFields = textFields.filter{ $0.isHidden == false }
        
        //sort by y position
        textFields.sort { (txf1, txf2) -> Bool in
            return txf1.frame.origin.y < txf2.frame.origin.y
        }
        
        //get index of 'sender' in array
        guard let index = textFields.firstIndex(of: sender) else {
            //sender in not in stackview
            return
        }
        
        if index + 1 >= textFields.count{
            //last one
            closeKeyboardAction(sender)
        } else {
            //next field -> open keyboard
            textFields[index + 1].becomeFirstResponder()
        }
    }
    
    
    
    
    
}

