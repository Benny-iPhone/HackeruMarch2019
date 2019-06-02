//
//  PersonCell.swift
//  SegementedTableView
//
//  Created by hackeru on 02/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    func populate(with person : Person){
        
        textLabel?.text = person.first_name + " " + person.last_name
        detailTextLabel?.text = person.date + " | " + person.email
        
    }

}
