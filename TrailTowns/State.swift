//
//  StateInfo.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/21/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import Foundation
import Parse

class State {
    var stateName: String!
    var townsInState: [PFObject]!
    
    init(name:String) {
        stateName = name
        townsInState = [PFObject]()
    }
}