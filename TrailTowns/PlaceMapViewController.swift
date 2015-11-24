//
//  ViewController.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/16/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import UIKit
import MapKit
import Parse

class PlaceMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var townId:String?
    var townLat:String?
    var townLong:String?
    
    var places = [PFObject]()
    let mapDelta:CLLocationDegrees = 0.12
    
    var placeId = ""
    
    @IBOutlet weak var map: MKMapView!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.mapType = MKMapType.Standard
        map.hidden = true
        
        for place in places {
            
            if let name = place["name"] as? String {
                if let lat = place["lat"] as? String{
                    if let long = place["long"] as? String {
                        let coordinate = CLLocationCoordinate2DMake((lat as NSString).doubleValue, (long as NSString).doubleValue)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = name
                        self.map.addAnnotation(annotation)
                    }
                }
            }
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier("AnnotationView Id")
        if annotation is MKUserLocation {
            return nil
        } else {
            if view == nil{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView Id")
                view!.canShowCallout = true
            } else {
                view!.annotation = annotation
            }
            view?.leftCalloutAccessoryView = nil
            view?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            
            return view
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            
            let selectedPlaceName = view.annotation!.title!
            
            let query = PFQuery (className: "Places")
            query.whereKey("name", equalTo: selectedPlaceName!)
            
            query.findObjectsInBackgroundWithBlock { (results, error) in
                if (error == nil) {
                    self.placeId = (results?.first!.objectId!)!
                } else {
                    print("Error retrieving place.")
                }
                self.performSegueWithIdentifier("placeMapToPlace", sender: view)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        map.showsUserLocation = true
        map.showsPointsOfInterest = true
        
        if let latitude = townLat {
            if let longitude = townLong {
                map.hidden = false
                let coordinate = CLLocationCoordinate2DMake((latitude as NSString).doubleValue, (longitude as NSString).doubleValue)
                let span:MKCoordinateSpan = MKCoordinateSpanMake(mapDelta, mapDelta)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
                self.map.setRegion(region, animated: true)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "placeMapToPlace") {
            let destinvationVC = segue.destinationViewController as! PlaceInfoViewController
            destinvationVC.placeId = placeId
        }
    }
    
}

