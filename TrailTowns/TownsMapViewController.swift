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

class TownsMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var towns = [PFObject]();
    var selectedTownId:String?
    var selectedTownName:String?
    var selectedTownLat:String?
    var selectedTownLong:String?
    
    let mapLat =  41.5
    let mapLong = -76.5
    let mapDelta = 14.8
    
    @IBOutlet weak var map: MKMapView!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.mapType = MKMapType.Standard
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        map.showsUserLocation = true
        map.showsPointsOfInterest = true
        
        let coordinate = CLLocationCoordinate2DMake(mapLat, mapLong)
        let span:MKCoordinateSpan = MKCoordinateSpanMake(mapDelta, mapDelta)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        map.setRegion(region, animated: true)
        
        for town in towns {
            if let name = town["name"] as? NSString {
                let latitude = (town["lat"] as! NSString).doubleValue
                let longitude = (town["long"] as! NSString).doubleValue
                let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = coordinate
                annotation.title = name as String
                self.map.addAnnotation(annotation)
            }
        }
    }

    
    // MARK: - Annotations
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "TownPin"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        if view == nil{
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
                view!.image = UIImage(named:"townPin.png")
                view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
                view!.leftCalloutAccessoryView = nil
            } else {
                view!.annotation = annotation
            }
        
            return view
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            
            let selectedTownName = view.annotation!.title!!
            
            
            let query = PFQuery (className: "Towns")
            query.whereKey("name", equalTo: selectedTownName)
            
            query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
                if (error == nil) {
                    let result = results?.first!
                    self.selectedTownId = result!.objectId!
                    self.selectedTownLat = result!["lat"] as? String
                    self.selectedTownLong = result!["long"] as? String
                    self.selectedTownName = result!["name"] as? String
                } else {
                    print("Error retrieving services.")
                }
                self.performSegueWithIdentifier("TownMapToServices", sender: view)
            }
            
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "TownMapToServices") {
            let destinvationVC = segue.destinationViewController as! ServicesTableViewController
            destinvationVC.townId = selectedTownId
            destinvationVC.townLat = selectedTownLat
            destinvationVC.townLong = selectedTownLong
            destinvationVC.townName = selectedTownName
        }
    }
    
}

