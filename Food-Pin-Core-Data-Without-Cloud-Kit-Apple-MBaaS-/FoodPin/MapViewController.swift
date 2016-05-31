//
//  MapViewController.swift
//  FoodPin
//
//  Created by Admin on 3/24/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        
        title = "Map \(self.restaurant.name)'s Restaurant"
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            
            if error != nil {
                print(error)
                return
            }
            
            if placemarks != nil && placemarks!.count > 0 {
            
                let placemark = placemarks![0] as CLPlacemark
            
                let restaurant = MKPointAnnotation()
                
                restaurant.coordinate = placemark.location!.coordinate
                
                restaurant.title = self.restaurant.name
                restaurant.subtitle = self.restaurant.type
                
                self.mapView.showAnnotations([restaurant], animated: true)
                self.mapView.selectAnnotation(restaurant, animated: true)
                
                
            }
            
            }
        )
        
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
        
        leftIconView.image = UIImage(data: restaurant.image)
        
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
        
    }
    
    
    
    

}
