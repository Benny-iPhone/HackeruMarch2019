//
//  MapContainerView.swift
//  Maze
//
//  Created by hackeru on 30/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import GoogleMaps

class MapContainerView: UIView , GMSMapViewDelegate{
    
    weak var mapView : GMSMapView?
    var isMapReady : Bool = false
    
    func mapViewSnapshotReady(_ mapView: GMSMapView) {
        self.isMapReady = true
    }
    
    func embedMapView(){
        let mapView = GMSMapView(frame: .zero)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(mapView)
        
        [
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ].forEach{ $0.isActive = true }
        
        self.mapView = mapView
    }
    
    private func polylines(from path : GMSPath) -> [GMSPolyline]
    {
        let count = path.count()
        guard count >= 2 else { return [] }
        
        var arr : [GMSPolyline] = []
        for i in 0..<count - 1{
            let subPath = GMSMutablePath()
            subPath.add(path.coordinate(at: i))
            subPath.add(path.coordinate(at: i + 1))
            arr += [GMSPolyline(path: subPath)]
        }
        
        return arr
        
    }
    
    //@discardableResult
    func populateMap(with arr : [(latitude : Double, longitude : Double)]) -> Bool{
        guard let mapView = self.mapView, self.isMapReady else {
            return false
        }
        
        //cleanup
        mapView.clear()
        
        // --- populate ---
        
        //full path
        let path = GMSMutablePath()
        for p in arr{
            path.addLatitude(p.latitude, longitude: p.longitude)
        }
        
        //focus map to path
        let mapBounds = GMSCoordinateBounds(path: path)
        mapView.animate(with: GMSCameraUpdate.fit(mapBounds))
        
        //create polylines
        let p = GMSPolyline(path: path)
        p.strokeColor = .lightGray
        p.strokeWidth = 2
        p.map = mapView
        
        var interval : TimeInterval = 1.5
        for p in polylines(from: path){
            
            p.strokeColor = .blue
            p.strokeWidth = 3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                p.map = mapView
            }
            
            interval += 0.1
        }
        
        return true
    }
}

























