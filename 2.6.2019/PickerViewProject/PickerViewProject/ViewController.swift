//
//  ViewController.swift
//  PickerViewProject
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }

}

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    //MAKR: - Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1_000 * (component + 1) //10_000_000
    }
    
    //MARK: - Delegate
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Row \(row)"
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let str = "Row \(row)"
        let attString = NSMutableAttributedString(string: str)
        let range = NSRange(location: 0, length: str.count)
        if (row + component) % 2 == 0{
            //attString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: range)
            attString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        } else {
            //attString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 20), range: range)
            attString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        }
        
        let rowRange = (str as NSString).range(of: "Row")
        if rowRange.location != NSNotFound{
            attString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rowRange)
        }
        
        return attString
        
    }
    
    
    
}
