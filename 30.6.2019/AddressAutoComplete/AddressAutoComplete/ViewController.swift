//
//  ViewController.swift
//  AddressAutoComplete
//
//  Created by hackeru on 30/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var addressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addressTextField.delegate = self
    }
    
    private func showGoogleAutoCompleteVC(){
        let vc = GMSAutocompleteViewController()
        vc.delegate = self
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        vc.autocompleteFilter = filter
        
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - UITextField Delegate

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case addressTextField:
            showGoogleAutoCompleteVC()
            return false
        default:
            return true
        }
    }
}

extension ViewController : GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        addressTextField.text = place.formattedAddress
        
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
