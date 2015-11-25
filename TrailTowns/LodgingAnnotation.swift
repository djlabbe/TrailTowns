//
//  LodgingAnnotation.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/24/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import Foundation
import MapKit

class LodgingAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}