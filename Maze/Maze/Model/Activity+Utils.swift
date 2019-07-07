//
//  Activity+Utils.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import CoreLocation

extension Step{
    var location : CLLocation{
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

extension Activity{
    var steps : [Step]{
        let arr = path?.array as? [Step] ?? []
        return arr.sorted(by: { (s1, s2) -> Bool in
            return (s1.date?.timeIntervalSince1970 ?? 0) < (s2.date?.timeIntervalSince1970 ?? 0)
        })
    }
    
    var duration : TimeInterval?{
        guard let start = self.startDate, let end = self.endDate else{
            return nil
        }
        
        return end.timeIntervalSince1970 - start.timeIntervalSince1970
    }
    
    var distance : CLLocationDistance?{ //meters
        
        let steps = self.steps
        guard steps.count >= 2 else{
            return nil
        }
        
        var total : CLLocationDistance = 0
        for i in 0..<(steps.count-1){
            let subDistance = steps[i].location.distance(from: steps[i+1].location)
            total += subDistance
        }
        
        return total
    }
    
}
