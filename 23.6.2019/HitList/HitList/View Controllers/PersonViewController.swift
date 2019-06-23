//
//  PersonViewController.swift
//  HitList
//
//  Created by hackeru on 23/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    
    var person : Person? //contains value in edit mode

    weak var firstNameTextField : UITextField!
    weak var lastNameTextField : UITextField!
    weak var genderSegment : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if person == nil{
            navigationItem.title = "Add a Person"
        } else {
            navigationItem.title = "Edit a Person"
        }
        view.backgroundColor = .white
        
        buildUI()
        populateUI()
    }
    
    private func populateUI(){
        guard let person = self.person else { return }
        firstNameTextField.text = person.firstName
        lastNameTextField.text = person.lastName
        genderSegment.selectedSegmentIndex = person.personGender.intValue
    }

    private func buildUI(){
        //first name text field
        
        let firstNameTextField = UITextField(frame: .zero)
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.borderStyle = .roundedRect
        firstNameTextField.font = UIFont.systemFont(ofSize: 16)
        firstNameTextField.autocorrectionType = .no
        firstNameTextField.spellCheckingType = .no
        
        //last name text field
        let lastNameTextField = UITextField(frame: .zero)
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.borderStyle = .roundedRect
        lastNameTextField.font = UIFont.systemFont(ofSize: 16)
        lastNameTextField.autocorrectionType = .no
        lastNameTextField.spellCheckingType = .no
        
        //gender segmented control
        
        let segment = UISegmentedControl(items: Person.Gender.all.compactMap{ $0.title} )
        segment.selectedSegmentIndex = 0
        
        //submit button
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.tintColor = UIColor(red: 0, green: 122/255.0, blue: 1, alpha: 1)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        
        //StackView
        
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField,lastNameTextField,segment,button])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        //add to UI
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        [
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
            ].forEach{ $0.isActive = true }
        
        //hook UI
        self.firstNameTextField = firstNameTextField
        self.lastNameTextField = lastNameTextField
        self.genderSegment = segment
        
        button.addTarget(self, action: #selector(submitAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func submitAction(_ sender : Any)
    {
        guard let firstName = firstNameTextField.text, firstName.count > 0,
            let lastName = lastNameTextField.text, lastName.count > 0 else { return }
        
        //p is self.person if we are in EDIT mode, or a new person for CREATE mode
        let p = self.person ?? Person(context: Database.shared.context)
        p.firstName = firstName
        p.lastName = lastName
        
        for g in Person.Gender.all{
            if g.intValue == genderSegment.selectedSegmentIndex{
                p.personGender = g
                break
            }
        }
        
        p.createdAt = Date()
        
        Database.shared.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }

}
