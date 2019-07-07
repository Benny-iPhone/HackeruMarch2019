//
//  TaxiCell.swift
//  MultipleTargets
//
//  Created by hackeru on 07/07/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class TaxiCell: UITableViewCell {

    func populate(with t : Taxi){
        
        textLabel?.text = t.username
        
        let distance = AppModel.model.currentLocation.distance(from: t.location)
        
        detailTextLabel?.text = String(format:"%.2f KM",distance / 1_000)
        
    }

}
