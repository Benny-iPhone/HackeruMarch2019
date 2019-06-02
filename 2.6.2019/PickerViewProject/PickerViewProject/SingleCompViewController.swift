//
//  SingleCompViewController.swift
//  PickerViewProject
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class SingleCompViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    let pickerArray : [String] = ["Real Madrid",
                                  "Barcelona",
                                  "Liverpool",
                                  "Manchester United",
                                  "Manchester City",
                                  "Tottenham",
                                  "Chelsea"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
    }
    

}

extension SingleCompViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: .zero)
        if row % 2 == 0{
            label.font = UIFont.boldSystemFont(ofSize: 20)
        } else {
            label.font = UIFont.italicSystemFont(ofSize: 20)
        }
        
        label.text = pickerArray[row]
        label.textAlignment = .left
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = pickerArray[row]
    }
}
