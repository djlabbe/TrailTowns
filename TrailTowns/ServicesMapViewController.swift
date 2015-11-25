//
//  ViewController.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/16/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

// Map icons used under creative commons lisence courtesy of https://mapicons.mapsmarker.com/

import UIKit
import MapKit
import Parse

class ServicesMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var townId:String?
    var townLat:String?
    var townLong:String?
    var placeId:String?
    var places = [PFObject]()
    let mapDelta:CLLocationDegrees = 0.04
    
    @IBOutlet weak var map: MKMapView!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.mapType = MKMapType.Standard
        map.hidden = true
        
        for place in places {
            
            if let name = place["name"] as? String {
                if let lat = place["lat"] as? String {
                    if let long = place["long"] as? String {
                        let coordinate = CLLocationCoordinate2DMake((lat as NSString).doubleValue, (long as NSString).doubleValue)
                        let primaryFunc = place["primaryFunc"] as! String
                        switch(primaryFunc) {
                        case "Lodging":
                            let annotation = LodgingAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "Camping":
                            let annotation = CampingAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "Food":
                            let annotation = RestaurantAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "ResupplyS":
                            let annotation = ResupplySAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "ResupplyL":
                            let annotation = ResupplyLAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "Outfitter":
                            let annotation = OutfitterAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "Post":
                            let annotation = PostAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "Medical":
                            let annotation = MedicalAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "Transportation":
                            let annotation = TransportationAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        case "Laundry":
                            let annotation = LaundryAnnotation(coordinate: coordinate, title:name, subtitle:"")
                            self.map.addAnnotation(annotation)
                            break
                        default:
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate
                            annotation.title = name
                            self.map.addAnnotation(annotation)
                        }
                    }
                }
            }
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        if annotation is LodgingAnnotation {
            
            let reuseId = "Lodging"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"lodging.png")
            
            return view
        
        } else if annotation is CampingAnnotation {
            let reuseId = "Camping"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"camping.png")
            
            return view
            
        } else if annotation is RestaurantAnnotation {
            let reuseId = "Restaurant"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"restaurant.png")
            
            return view
    
        } else if annotation is ResupplySAnnotation {
            let reuseId = "ResupplyS"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"resupplyS.png")
            
            return view
            
        } else if annotation is ResupplyLAnnotation {
            let reuseId = "ResupplyL"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"resupplyL.png")
            
            return view
            
        } else if annotation is OutfitterAnnotation {
            let reuseId = "Outfitter"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"outfitter.png")
            
            return view
            
        } else if annotation is PostAnnotation {
            let reuseId = "Post"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"post.png")
            
            return view
            
        } else if annotation is MedicalAnnotation {
            let reuseId = "Medical"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"medical")
            
            return view
    
        } else if annotation is TransportationAnnotation {
            let reuseId = "Transportation"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"transportation.png")
            
            return view
            
        } else if annotation is LaundryAnnotation {
            let reuseId = "Laundry"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            }
            else {
                view!.annotation = annotation
            }
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            view!.image = UIImage(named:"laundry.png")
            
            return view
            
        } else { // DEFAULT
            
            let reuseId = "Default"
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                view!.canShowCallout = true
            } else {
                view!.annotation = annotation
            }
            view!.leftCalloutAccessoryView = nil
            view!.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
            return view
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            
            let selectedPlaceName = view.annotation!.title!!
            
            let query = PFQuery (className: "Places")
            query.whereKey("name", equalTo: selectedPlaceName)
            
            query.findObjectsInBackgroundWithBlock { (results, error) in
                if (error == nil) {
                    self.placeId = (results?.first!.objectId!)!
                } else {
                    print("Error retrieving place.")
                }
                self.performSegueWithIdentifier("townMapToPlace", sender: view)
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
        if (segue.identifier == "townMapToPlace") {
            let destinvationVC = segue.destinationViewController as! PlaceInfoViewController
            destinvationVC.placeId = placeId
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

