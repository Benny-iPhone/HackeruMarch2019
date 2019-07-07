//
//  ActivityCell.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import MapKit

class ActivityCell: UITableViewCell {
    
    private weak var workItem : DispatchWorkItem?

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var mapContainerView: MapContainerView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mapContainerView?.embedMapView()
    }
    
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
        
        if let distance = activity.distance{
            let formatter = MKDistanceFormatter()
            formatter.unitStyle = .abbreviated //km
            formatter.units = .metric
            
            distanceLabel.text = formatter.string(fromDistance: distance)
        } else {
            distanceLabel.text = "N/A"
        }
        
        //cancel - stop previous loadMap command
        self.workItem?.cancel()
        
        if let mapContainer = self.mapContainerView{
            let arr = activity.steps.compactMap{ ($0.latitude,$0.longitude)}

            func loadMap(){
                if !mapContainer.populateMap(with: arr){
                    let workItem = DispatchWorkItem(block: loadMap)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
                    self.workItem = workItem

//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        loadMap()
//                    }
                }
            }
            
            loadMap()
        }
    }

}
