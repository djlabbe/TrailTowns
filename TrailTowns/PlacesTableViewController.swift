//
//  PlacesTableViewController.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/16/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import UIKit
import Parse

class PlacesTableViewController: UITableViewController {
    
    var places = [PFObject]()
    var placeNames = [String]()
    
    var serviceTypes:[String:String] = ["Lodging":"isLodging", "Camping":"isTent", "Restaurants":"isRestaurant",
        "Short-Term Resupply":"isResupplyS", "Long-Term Resupply": "isResupplyL", "Outfitters":"isOutfitter", "Post Office":"isPost", "Medical":"isMedical", "Transportation":"isTransport", "Shower":"isShower", "Laundry":"isLaundry", "Wifi":"isWifi"]
    
    var townId:String?
    var townLat:String?
    var townLong:String?
    var serviceType:String?
    
    
    var selectedPlaceName:String?
    var selectedPlaceId:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = serviceType
        
        self.tableView.backgroundColor = gray1
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let nib = UINib(nibName: "PlaceCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        if let keyToQuery = serviceTypes[serviceType!] {
            let query = PFQuery(className: "Places")
            query.whereKey(keyToQuery, equalTo: true)
            query.includeKey("town")
            query.orderByAscending("name")
            query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
                if (error == nil){
                    if let places = results {
                        for place in places {
                            if let parentPointer:PFObject = place["town"] as? PFObject{
                                if(parentPointer.objectId == self.townId){
                                
                                self.places.append(place)
                                self.placeNames.append( place["name"] as! (String) )
                                    
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }else{
                    print(error?.localizedDescription)
                }
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
        return placeNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PlacesTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! PlacesTableViewCell
        
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
        
        cell.placeNameLabel?.text = placeNames[indexPath.row]
        
        if let placeImageFile = places[indexPath.row]["mainImage"] as? PFFile {
            placeImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        cell.placeImage.image = UIImage(data:imageData)
                    }
                }
                else {
                    print(error?.localizedDescription)
                }
            }
        } else {
            cell.placeImage.image = UIImage(named: "questionmark.png")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow

        
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)! as! PlacesTableViewCell
    
        selectedPlaceName = currentCell.placeNameLabel!.text!
        
        selectedPlaceId = places[indexPath!.row].objectId!
        
        performSegueWithIdentifier("placesToPlace", sender: self)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "placesToPlace") {
            let destinvationVC = segue.destinationViewController as! PlaceInfoViewController
            destinvationVC.placeId = selectedPlaceId!
            destinvationVC.placeName = selectedPlaceName!
            destinvationVC.serviceType = serviceType!
        } else if (segue.identifier == "placesToMap") {
            let destinvationVC = segue.destinationViewController as! PlaceMapViewController
            destinvationVC.places = places
            destinvationVC.townId = townId
            destinvationVC.townLat = townLat
            destinvationVC.townLong = townLong
        }
    }
}
