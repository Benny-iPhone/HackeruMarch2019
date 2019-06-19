//
//  PlaceDetailsViewController.swift
//  LocationsProject
//
//  Created by hackeru on 19/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

extension CLPlacemark{
    var uiString : String{
        var arr : [String] = []
        if let country = self.country{ arr += [country] }
        if let state = self.administrativeArea { arr += [state] }
        if let city = self.subAdministrativeArea { arr += [city] }
        if let street = self.thoroughfare { arr += [street] }
        if let number = self.subThoroughfare { arr += [number] }
        
        return arr.joined(separator: " ")
        
    }
}

class PlaceDetailsViewController: UIViewController {
    
    var place : Place!
    
    @IBOutlet weak var textView: UITextView!
    //@IBOutlet weak var descriptionLabel : UILabel!
    //@IBOutlet weak var addressLabel : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateUI()
    }
    
    private func populateUI(){
        navigationItem.title = place.name
        textView.text = place.description
        //descriptionLabel.text = place.description
        imageView.sd_setImage(with: URL(string: place.imageUrl))
        
        //addressLabel.text = ""
        fetchAddress { [weak self] address in
            guard let strongSelf = self else { return }
            strongSelf.textView.text = strongSelf.place.description + "\n" + address
            //self?.addressLabel.text = address
        }
    }
    
    private func fetchAddress(with callback : @escaping (String)->Void){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(place.location) { (placemarks, err) in
            guard let p = placemarks?.first else {
                callback("")
                return
            }
            
            callback(p.uiString)
        }
    }
    
    @IBAction func navigateAction(_ sender: Any) {
    }
    

}










