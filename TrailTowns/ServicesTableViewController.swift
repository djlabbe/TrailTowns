//
//  ServicesTableViewController.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/16/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

// MAP ICON ART FROM https://mapicons.mapsmarker.com

import UIKit
import Parse

class ServicesTableViewController: UITableViewController {
    
    var townId:String?
    var townName:String?
    var townLat:String?
    var townLong:String?
    
    var selectedServiceType:String?
    var serviceList = [String]()
    var places = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(self.townName!)"
        self.tableView.backgroundColor = gray1
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let nib = UINib(nibName: "ServiceCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")

        let query = PFQuery(className: "Places")
        query.includeKey("town")
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if (error == nil){
                if let places = results {
                    for place in places {
                        if let parentPointer:PFObject = place["town"] as? PFObject{
                            if(parentPointer.objectId == self.townId){
                                
                                self.places.append(place)
                                
                                if (place["isLodging"] as! Bool && !self.serviceList.contains("Lodging")) { self.serviceList.append("Lodging") }
                                if (place["isTent"] as! Bool && !self.serviceList.contains("Camping")) { self.serviceList.append("Camping") }
                                if (place["isRestaurant"] as! Bool && !self.serviceList.contains("Restaurants")) { self.serviceList.append("Restaurants") }
                                if (place["isResupplyS"] as! Bool && !self.serviceList.contains("Short-Term Resupply")) { self.serviceList.append("Short-Term Resupply") }
                                if (place["isResupplyL"] as! Bool && !self.serviceList.contains("Long-Term Resupply")) { self.serviceList.append("Long-Term Resupply") }
                                if (place["isOutfitter"] as! Bool && !self.serviceList.contains("Outfitters")) { self.serviceList.append("Outfitters") }
                                if (place["isPost"] as! Bool && !self.serviceList.contains("Post Office")) { self.serviceList.append("Post Office") }
                                if (place["isMedical"] as! Bool && !self.serviceList.contains("Medical")) { self.serviceList.append("Medical") }
                                if (place["isTransport"] as! Bool && !self.serviceList.contains("Transportation")) { self.serviceList.append("Transportation") }
                                if (place["isLaundry"] as! Bool && !self.serviceList.contains("Laundry")) { self.serviceList.append("Laundry") }
                                if (place["isShower"] as! Bool && !self.serviceList.contains("Shower")) { self.serviceList.append("Shower") }
                                if (place["isWifi"] as! Bool && !self.serviceList.contains("Wifi")) { self.serviceList.append("Wifi") }
                                
                            }
                        }
                    }
                }
                self.serviceList.sortInPlace()
                self.tableView.reloadData()
            }else{
                print(error?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ServiceTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! ServiceTableViewCell
        
        switch (indexPath.row % 3) {
        case 0:
            cell.backgroundColor = gray1
            break
        case 1:
            cell.backgroundColor = gray2
            break
        case 2:
            cell.backgroundColor = lightGray
            break
        default:
            break
        }
            
        let serviceName = serviceList[indexPath.row]
        cell.nameLabel?.text = serviceName
        cell.imageView!.image =  UIImage(named: "\(serviceName).png")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as! ServiceTableViewCell

        selectedServiceType = currentCell.nameLabel!.text!
        
        performSegueWithIdentifier("servicesToPlaces", sender: self)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "servicesToPlaces") {
            let destinvationVC = segue.destinationViewController as! PlacesTableViewController
            destinvationVC.townId = townId
            destinvationVC.townLat = townLat
            destinvationVC.townLong = townLong
            destinvationVC.serviceType = selectedServiceType
            
        } else if (segue.identifier == "servicesToMap") {
            let destinvationVC = segue.destinationViewController as! ServicesMapViewController
            destinvationVC.townId = townId
            destinvationVC.townLat = townLat
            destinvationVC.townLong = townLong
            destinvationVC.places = places
        }
    }
}
