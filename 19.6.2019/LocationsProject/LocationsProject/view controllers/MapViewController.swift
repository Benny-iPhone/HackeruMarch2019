//
//  MapViewController.swift
//  LocationsProject
//
//  Created by hackeru on 19/06/2019.
//  Copyright © 2019 hackeru. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        let arr = Place.loadFrom(file: "places").compactMap{ PlaceWrapper($0) }
        
        mapView.addAnnotations(arr)
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "ann")
        if annView == nil{
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "ann")
            pinView.pinTintColor = MKPinAnnotationView.greenPinColor()
            pinView.canShowCallout = true
            
            pinView.rightCalloutAccessoryView = UIButton(type: .infoLight)
            
            annView = pinView
        } else {
            annView?.annotation = annotation
        }
        
        return annView
    }
    
    //info button in annotation bubble pressed
    
    func mapView(_ mapView: MKMapView, annotationView annView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PlaceDetailsViewController") as? PlaceDetailsViewController else{
            return
        }
        
        guard let placeWrapper = annView.annotation as? PlaceWrapper else { return }
        
        detailsVC.place = placeWrapper.place
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybridFlyover
        default:
            break
        }
        
    }
    
}
