//
//  PlaceCell.swift
//  LocationsProject
//
//  Created by hackeru on 19/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //round
        placeImageView.layer.masksToBounds = true
        placeImageView.layer.cornerRadius = 25
    }
    
    func populate(with place : Place){
        nameLabel.text = place.name
        
        placeImageView.sd_setImage(with: URL(string: place.imageUrl))
        
        if let userLocation = LocationTracker.shared.location{
            
            let distance = userLocation.distance(from: place.location) //distance in meters
            
            //see MKDistanceFormatter
            distanceLabel.text = String(format: "%.2f KM away", distance / 1_000)
            
        } else {
            distanceLabel.text = ""
        }
    }

}
