//
//  ActivityCell.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    func populate(with activity : Activity){
        
        if let startDate = activity.startDate{
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            formatter.doesRelativeDateFormatting = true
            
            dateLabel.text = formatter.string(from: startDate)
        } else {
            dateLabel.text = "N/A"
        }

        if let duration = activity.duration{
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.allowedUnits = [.hour,.minute,.second]
            formatter.zeroFormattingBehavior = .dropLeading
            
            durationLabel.text = formatter.string(from: duration)
        } else {
            durationLabel.text = "N/A"
        }
    }

}
