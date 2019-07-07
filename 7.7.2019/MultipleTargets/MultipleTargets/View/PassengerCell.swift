//
//  PassengerCell.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class PassengerCell: UITableViewCell {

    func populate(with p : Passenger){
        
        textLabel?.text = p.first_name + " " + p.last_name
        
        let distance = AppModel.model.currentLocation.distance(from: p.location)
        
        detailTextLabel?.text = String(format: "%.2f KM",distance/1_000)
        
    }

}
