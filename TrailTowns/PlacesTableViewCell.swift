//
//  PlaceTableViewCell.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/21/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = darkGray
        
        placeImage.layer.cornerRadius = 37.5
        placeImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
