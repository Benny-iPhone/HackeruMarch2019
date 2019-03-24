//
//  ViewController.swift
//  DateConvertor
//
//  Created by hackeru on 24/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Mode : Int{
        case gregToHeb //0
        case hebToGreg //1
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    
    func currentMode() -> Mode{
        return segmentedControl.selectedSegmentIndex == 0 ? .gregToHeb : .hebToGreg
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.text = "Hi 😍"
        
        //First way
        self.datePickerAction(datePicker)
        
        //Second Way
        datePicker.sendActions(for: .valueChanged)
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        switch self.currentMode() {
        case .gregToHeb:
            datePicker.calendar = Calendar(identifier: .gregorian)
            datePicker.locale = Locale(identifier: "en")
        case .hebToGreg:
            datePicker.calendar = Calendar(identifier: .hebrew)
            datePicker.locale = Locale(identifier: "he")
        }
        
        datePickerAction(datePicker)
        
    }
    

    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
        //label.text = sender.date.description
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = DateFormatter.Style.none
        
        switch self.currentMode() {
        case .gregToHeb:
            formatter.calendar = Calendar(identifier: .hebrew)
            formatter.locale = Locale(identifier: "he")
            
        case .hebToGreg:
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.locale = Locale(identifier: "en")
        }
    
        let date : Date = sender.date
        label.text = formatter.string(from: date)
        
        
    }
    
    
    

}

