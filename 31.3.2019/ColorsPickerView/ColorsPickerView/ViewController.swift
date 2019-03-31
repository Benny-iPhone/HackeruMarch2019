//
//  ViewController.swift
//  ColorsPickerView
//
//  Created by hackeru on 31/03/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
    }

}

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Colors(rawValue: row)?.displayName
        //return "Row \(row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        targetView.backgroundColor = Colors(rawValue: row)?.uiColor
        print("selected row \(row)")
    }
}
