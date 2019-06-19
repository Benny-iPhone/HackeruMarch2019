//
//  Place.swift
//  LocationsProject
//
//  Created by hackeru on 19/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

struct Place : Codable{
    let id : String
    let name : String
    let description : String
    let latitude : Double
    let longitude : Double
    let imageUrl : String
    
    static func loadFrom(file : String) -> [Place]
    {
        //validate file
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else{
            return []
        }
        
        //load binary data from file
        guard let data = try? Data(contentsOf: url) else {
            return []
        }
        
        //parse
        do{
            let arr = try JSONDecoder().decode([Place].self, from: data)
            return arr
        } catch {
            print(error)
            return []
        }
        
    }
}

extension Place{
    
    var location : CLLocation{
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
}

class PlaceWrapper : NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
    }
    
    var title: String? { return place.name }
    //var subtitle: String? { return place.description }

    let place : Place
    init(_ place : Place){
        self.place = place
    }
}
