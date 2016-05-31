//
//  MapViewController.swift
//  Virtual Tour
//
//  Created by Admin on 5/2/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var etonProperty = RealEstate()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(etonProperty.location) { (placemarks, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            if placemarks != nil && placemarks?.count > 0 {
                
                let placemark = placemarks![0] as CLPlacemark
                let etonProperty = MKPointAnnotation()
                etonProperty.coordinate = (placemark.location?.coordinate)!
                
                etonProperty.title = self.etonProperty.developer
                etonProperty.subtitle = self.etonProperty.name
                
                self.mapView.showAnnotations([etonProperty], animated: true)
                self.mapView.selectAnnotation(etonProperty, animated: true)
                
            }
            
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        //        Reuser the annotaion if possible
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        
        leftIconView.image = UIImage(named: "lefticonview.jpg")
        
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
        
    }
    
    
    

}
