//
//  TownsTableViewController.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/16/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import UIKit
import Parse

class TownsTableViewController: UITableViewController {
    
    var stateList = [State(name: "Georgia"), State(name: "North Carolina & Tennessee"), State(name: "Virginia"), State(name: "West Virginia"), State(name: "Maryland"), State(name: "Pennsylvania"), State(name: "New Jersey"), State(name: "New York"), State(name: "Connecticut"), State(name: "Massachusettes"), State(name: "Vermont"), State(name: "New Hampshire"), State(name: "Maine")]
    
    var towns = [PFObject]();
    var selectedTownId:String?
    var selectedTownName:String?
    var selectedTownLat:String?
    var selectedTownLong:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkGray
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        let nib = UINib(nibName: "TownCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        
        let query = PFQuery (className: "Towns")
        query.orderByAscending("milesNorth")
        
        query.findObjectsInBackgroundWithBlock { (results, error) in
            if (error == nil) {
                
                for result in results! {
                    
                    switch(result["state"] as! String) {
                    case "GA":
                        self.stateList[0].townsInState.append(result)
                        break
                    case "NC":
                        self.stateList[1].townsInState.append(result)
                        break
                    case "TN":
                        self.stateList[1].townsInState.append(result)
                        break
                    case "VA":
                        self.stateList[2].townsInState.append(result)
                        break
                    case "WV":
                        self.stateList[3].townsInState.append(result)
                        break
                    case "MD":
                        self.stateList[4].townsInState.append(result)
                        break
                    case "PA":
                        self.stateList[5].townsInState.append(result)
                        break
                    case "NJ":
                        self.stateList[6].townsInState.append(result)
                        break
                    case "NY":
                        self.stateList[7].townsInState.append(result)
                        break
                    case "CT":
                        self.stateList[8].townsInState.append(result)
                        break
                    case "MA":
                        self.stateList[9].townsInState.append(result)
                        break
                    case "VT":
                        self.stateList[10].townsInState.append(result)
                        break
                    case "NH":
                        self.stateList[11].townsInState.append(result)
                        break
                    case "ME":
                        self.stateList[12].townsInState.append(result)
                        break
                    default:
                        break
                    }
                    self.towns.append(result)
                }
            } else {
                print("Error retrieving towns")
            }
            
            self.tableView.reloadData()
        }
    }
 
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return stateList.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateList[section].townsInState.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return stateList[section].stateName
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TownTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! TownTableViewCell
        
        
        
        if let townName = stateList[indexPath.section].townsInState[indexPath.row]["name"] as? String {
            if let offSet = stateList[indexPath.section].townsInState[indexPath.row]["offset"] as? String {
                if let distance = stateList[indexPath.section].townsInState[indexPath.row]["milesNorth"] as? String {
                    cell.townNameLabel.text = "\(townName)"
                    cell.townOffsetLabel.text! = offSet
                    cell.milesTravelledLabel.text! = distance
                }
            }
        }
        
        if let townAccess = stateList[indexPath.section].townsInState[indexPath.row]["accessRoute"] as? String {
            cell.townAccessLabel.text! = townAccess

        }
        
        
        
        if let placeImageFile = stateList[indexPath.section].townsInState[indexPath.row]["mainImage"] as? PFFile {
            placeImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        cell.townImage.image = UIImage(data:imageData)
                    }
                }
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let section = indexPath!.section
        let index = indexPath!.row
        
        selectedTownId = stateList[section].townsInState[index].objectId!
        selectedTownName = stateList[section].townsInState[index]["name"] as? String
        selectedTownLat = stateList[section].townsInState[index]["lat"] as? String
        selectedTownLong = stateList[section].townsInState[index]["long"] as? String
        
        performSegueWithIdentifier("townsToServices", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = white //make the background color light blue
        header.textLabel!.textColor = darkGray //make the text white
        header.alpha = 0.8 //make the header transparent
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "townsToServices") {
            let destinvationVC = segue.destinationViewController as! ServicesTableViewController
            destinvationVC.townId = selectedTownId
            destinvationVC.townName = selectedTownName
            destinvationVC.townLat = selectedTownLat
            destinvationVC.townLong = selectedTownLong
        } else if (segue.identifier == "townsToMap") {
            let destinvationVC = segue.destinationViewController as! TownsMapViewController
            destinvationVC.towns = towns
        }
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
