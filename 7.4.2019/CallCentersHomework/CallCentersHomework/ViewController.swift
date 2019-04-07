//
//  ViewController.swift
//  CallCentersHomework
//
//  Created by hackeru on 07/04/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pickerArray : [CallCenter] = []
    var selectedCallCenter : CallCenter{
        get{
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            return pickerArray[selectedRow]
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerArray = CallCenter.all
        pickerView.dataSource = self
        pickerView.delegate = self
        
        refreshUIAccordingToSelectedCallCenter()
    }
    
    private func refreshUIAccordingToSelectedCallCenter(){
        
        let obj = self.selectedCallCenter
        label.text = obj.name
        
    }

    @IBAction func callAction(_ sender: Any) {
        
        let phone = self.selectedCallCenter.phone
        let urlString = "tel://" + phone.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let url = URL(string: urlString) else{
            return
        }
        
        guard UIApplication.shared.canOpenURL(url) else{
            print("tel not supported")
            return
        }
        
        UIApplication.shared.open(url, options: [:]) { (didOpen) in
            print("did open \(didOpen)")
        }
    }
    
}

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        refreshUIAccordingToSelectedCallCenter()
    }
    
}
