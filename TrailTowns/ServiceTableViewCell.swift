//
//  TownCellTableViewCell.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/20/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = darkGray
        iconImage.backgroundColor = darkGray
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
