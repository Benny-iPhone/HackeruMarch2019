//
//  DateTextField.swift
//  FormProject
//
//  Created by hackeru on 29/05/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ToolbarTextField : UITextField{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        let screenWidth = UIScreen.main.bounds.width
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        
        let button : UIBarButtonItem
        if returnKeyType == .next{
            button = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(buttonAction))
        } else {
            button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(buttonAction))
        }
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [spaceButton,button]
        self.inputAccessoryView = toolbar
        
    }
    
    @objc func buttonAction(){
        //act like return key press
        self.sendActions(for: .editingDidEndOnExit)
    }
}

class DateTextField: ToolbarTextField {
    
    private var datePicker : UIDatePicker{ return inputView as! UIDatePicker }
    
    var date : Date{
        get{
            return datePicker.date
        }
        set{
            datePicker.date = newValue
            datePickerAction(datePicker)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func setup(){
        super.setup()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        self.inputView = datePicker
        
        datePicker.addTarget(self, action: #selector(datePickerAction(_:)), for: .valueChanged)
    }
    
    @objc func datePickerAction(_ sender : UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        text = formatter.string(from: sender.date)
    }

}
