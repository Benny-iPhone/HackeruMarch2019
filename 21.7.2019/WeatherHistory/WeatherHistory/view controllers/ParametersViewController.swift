//
//  ParametersViewController.swift
//  WeatherHistory
//
//  Created by hackeru on 21/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ParametersViewController: UIViewController {
    @IBOutlet weak var fromTextField: FSCalendarTextField!
    @IBOutlet weak var toTextField: FSCalendarTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "resultsSegue":
            return fromTextField.selectedDate != nil && toTextField.selectedDate != nil
        default:
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? ResultsViewController{
            
            guard let fromDate = fromTextField.selectedDate, let toDate = toTextField.selectedDate else{
                return
            }
            
            nextVC.params = ResultsViewController.Params(from: fromDate, to: toDate)
            
        }
    }

}
