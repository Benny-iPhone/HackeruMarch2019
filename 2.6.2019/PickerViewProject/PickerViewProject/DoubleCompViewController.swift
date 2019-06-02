//
//  DoubleCompViewController.swift
//  PickerViewProject
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

struct Meal {
    let name : String
    let additions : [String]
}

class DoubleCompViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var label: UILabel!
    
    let data : [Meal]
    var mealNames : [String]
    var selectedMeal : Meal
    
    required init?(coder aDecoder: NSCoder) {
        
        let data = [
            Meal(name: "Soup", additions: ["Bread","Crutons","Soup Almons"]),
            Meal(name: "Shnizel", additions: ["Rice","Potato","Frech Fries","Salad"]),
            Meal(name: "Ceaser Salad", additions: ["Bread","Vegi Cheese"])
        ]
        
        self.data = data
        self.mealNames = data.compactMap{ $0.name }
        self.selectedMeal = data[0]
        
        super.init(coder: aDecoder)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refreshLabel()
    }
    
    private func refreshLabel(){
        let mealIndex = pickerView.selectedRow(inComponent: Comp.meal.rawValue)
        let additionIndex = pickerView.selectedRow(inComponent: Comp.addition.rawValue)
        
        label.text = mealNames[mealIndex] + " & " + selectedMeal.additions[additionIndex]
    }
}

extension DoubleCompViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    enum Comp : Int{
        case meal, addition
        static let count = 2
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Comp.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let comp = Comp(rawValue: component) else { return 0 }
        switch comp {
        case .meal: return mealNames.count
        case .addition: return selectedMeal.additions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let comp = Comp(rawValue: component) else { return nil }
        switch comp {
        case .meal: return mealNames[row]
        case .addition: return selectedMeal.additions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let comp = Comp(rawValue: component) else { return }
        switch comp {
        case .meal:
            //update selected meal
            selectedMeal = data[row]
            //update UI
            pickerView.reloadComponent(Comp.addition.rawValue)
            
        case .addition: break
        }
        
        refreshLabel()

    }
    
}
