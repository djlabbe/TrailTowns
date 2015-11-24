//
//  PlaceInfoViewController.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/17/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import UIKit
import MapKit
import Parse

class PlaceInfoViewController: UIViewController, CLLocationManagerDelegate  {
    
    let bgColor = darkGray
    var placeId:String?
    var placeName:String?
    var placeLat:Double?
    var placeLong:Double?
    var placeUrl:String?
    var placePhone:String?
    var serviceType:String?
    var place:PFObject?
    
    var availableServices = [String]()
    
    var manager: CLLocationManager!
    let mapDelta = 0.02

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var serviceImages: [UIImageView]!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var urlButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
    
        view.backgroundColor = bgColor
        descLabel.backgroundColor = bgColor
        
        addressButton.backgroundColor = midGreen2
        phoneButton.backgroundColor = midGreen
        urlButton.backgroundColor = darkGreen
        
        
        
        for image in serviceImages {
            image.backgroundColor = bgColor
        }
        mapView.mapType = MKMapType.Standard
        mapView.hidden = true
        
        self.addressButton.hidden = true
        

            let query = PFQuery(className: "Places")
            query.getObjectInBackgroundWithId(placeId!) { (result, error) in
                if (error == nil) {
                    
                    let place = result!
                    
                    if let name = place["name"] as? String {
                        self.titleLabel.text = name
                    } else {
                        self.titleLabel.text = "Some Place"
                    }
                    
                    if let phone = place["phone"] as? String {
                        self.phoneButton.setTitle(phone, forState: UIControlState.Normal)
                        self.placePhone = phone
                    } else {
                        self.phoneButton.hidden = true
                    }
                    
                    if let url = place["url"] as? String {
                        self.urlButton.setTitle(url, forState: UIControlState.Normal)
                        self.placeUrl = url
                    } else {
                        self.urlButton.hidden = true
                    }
                    
                    
                    if let address = place["address"] as? String {
                        if let city = place["city"] as? String {
                            if let state = place["state"] as? String {
                                if let zip = place["zip"] as? String {
                                        self.addressButton.hidden = false
                                        self.addressButton.setTitle("\(address) \(city), \(state) \(zip)", forState: UIControlState.Normal)
                                }
                            }
                        }
                    }
             
                    if let desc = place["desc"] as? String {
                        self.descLabel.text = desc
                    }
                    
                    
                    if let lat = (place["lat"] as? NSString)?.doubleValue {
                        if let long = (place["long"] as? NSString)?.doubleValue {
                            self.placeLat = lat
                            self.placeLong = long
                            let coordinate = CLLocationCoordinate2DMake(lat, long)
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                    
                    if place["isLodging"] as! Bool == true {
                        self.availableServices.append("Lodging")
                    }
                    if place["isTent"] as! Bool == true {
                        self.availableServices.append("Camping")
                    }
                    if place["isRestaurant"] as! Bool == true {
                        self.availableServices.append("Restaurants")
                    }
                    if place["isResupplyS"] as! Bool == true {
                        self.availableServices.append("Short-Term Resupply")
                    }
                    if place["isResupplyL"] as! Bool == true {
                        self.availableServices.append("Long-Term Resupply")
                    }
                    if place["isOutfitter"] as! Bool == true {
                        self.availableServices.append("Outfitters")
                    }
                    if place["isPost"] as! Bool == true {
                        self.availableServices.append("Post Office")
                    }
                    if place["isMail"] as! Bool == true {
                        self.availableServices.append("Mail")
                    }
                    if place["isMedical"] as! Bool == true {
                        self.availableServices.append("Medical")
                    }
                    if place["isTransport"] as! Bool == true {
                        self.availableServices.append("Transportation")
                    }
                    if place["isLaundry"] as! Bool == true {
                        self.availableServices.append("Laundry")
                    }
                    if place["isWifi"] as! Bool == true {
                        self.availableServices.append("Wifi")
                    }
                    if place["isShower"] as! Bool == true {
                        self.availableServices.append("Shower")
                    }
                    
                    var i = 0
                    for availableService in self.availableServices {
                        if i < 8 {
                            let imgName = "Icons/\(availableService).png"
                            self.serviceImages[i].image = UIImage(named: imgName)
                            
                        }
                        i++
                    }
                } else {
                    print(error?.localizedDescription)
                }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.showsPointsOfInterest = true
        
        if let lat = placeLat {
            if let long = placeLong {
                mapView.hidden = false
                let coordinate = CLLocationCoordinate2DMake(lat, long)
                let span:MKCoordinateSpan = MKCoordinateSpanMake(mapDelta, mapDelta)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    
    @IBAction func addressPressed(sender: UIButton) {
        let destinationName = placeName!
        let destinationCoords = CLLocationCoordinate2DMake(placeLat!, placeLong!)
        openMapInTransitMode(destinationName, destination: destinationCoords)
    }
    
    @IBAction func phonePressed(sender: UIButton) {
        
        if let numberToDial = placePhone {
            
            let phoneAlert = UIAlertController(title: "Do you want to call?", message: "\(numberToDial)", preferredStyle: UIAlertControllerStyle.Alert)
            
            phoneAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                if let url = NSURL(string: "tel://\(numberToDial)") {
                    UIApplication.sharedApplication().openURL(url)
                }
            }))
            
            phoneAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
                print("Call cancelled")
            }))
            
            presentViewController(phoneAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func urlPressed(sender: UIButton) {
        if let urlString = placeUrl {
            print(urlString)
            if let url = NSURL(string: urlString) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    func openMapInTransitMode(name:String, destination:CLLocationCoordinate2D) {
        let startLocation = manager.location
        let startPlacemark = MKPlacemark(coordinate: (startLocation?.coordinate)!, addressDictionary: nil)
        let start = MKMapItem(placemark: startPlacemark)
        start.name = "Current location"
        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        let destination = MKMapItem(placemark: destinationPlacemark)
        destination.name = name
        
        // Change to Walking for Production deploy
        let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMapsWithItems([start, destination], launchOptions: options)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
