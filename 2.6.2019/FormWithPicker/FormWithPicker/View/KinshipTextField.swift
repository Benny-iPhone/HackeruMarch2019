//
//  KinshipTextField.swift
//  FormWithPicker
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
/*
private class KinshipTextFieldPickerController : NSObject, UIPickerViewDataSource, UIPickerViewDelegate{
    var selectionCallback : ((Int)->Void)?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    
}
*/
class KinshipTextField: UITextField {

    //private var controller = KinshipTextFieldPickerController()
    
    enum Kinship : Int{
        case myself
        case sibling
        case parent
        case grandparent
        case child
        case grandchild
        case partner
        
        var displayName : String{
            switch self {
            case .myself: return "Myself"
            case .sibling: return "Sibling"
            case .parent: return "Parent"
            case .grandparent: return "Grapa / Grama"
            case .child: return "Boy / Girl"
            case .grandchild: return "Grand-son / Grand-daughter"
            case .partner: return "Partner"
            }
        }
        
    }
    
    var kinship : Kinship?{
        get{
            guard let pickerView = pickerView else { return nil }
            guard pickerView.numberOfComponents > 0 else { return nil }
            let selectedIndex = pickerView.selectedRow(inComponent: 0)
            return Kinship(rawValue: selectedIndex)
        }
        set{
            guard let val = newValue?.rawValue else { return }
            guard let pickerView = self.pickerView, pickerView.numberOfComponents > 0 else { return }
            pickerView.selectRow(val, inComponent: 0, animated: true)
            refreshText()
        }
    }
    
    private func refreshText(){
        self.text = kinship?.displayName
    }

    private var pickerView : UIPickerView?{
        return inputView as? UIPickerView
    }
    
    //storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup(){
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.inputView = pickerView
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        if result{ //keyboard opened
            refreshText()
        }
        
        return result
    }
}

extension KinshipTextField : UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Kinship.partner.rawValue + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Kinship(rawValue: row)?.displayName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        refreshText()
        self.sendActions(for: .editingChanged)
    }
}
