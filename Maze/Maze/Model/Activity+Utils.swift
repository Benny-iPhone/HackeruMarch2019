//
//  Activity+Utils.swift
//  Maze
//
//  Created by hackeru on 26/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import CoreLocation

extension Activity{
    var duration : TimeInterval?{
        guard let start = self.startDate, let end = self.endDate else{
            return nil
        }
        
        return end.timeIntervalSince1970 - start.timeIntervalSince1970
    }
    
}
