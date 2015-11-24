//
//  TownCellTableViewCell.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/20/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import UIKit

class TownTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var townImage: UIImageView!
    @IBOutlet weak var townNameLabel: UILabel!
    @IBOutlet weak var townOffsetLabel: UILabel!
    @IBOutlet weak var milesTravelledLabel: UILabel!
    @IBOutlet weak var townAccessLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = darkGray
        
    
        self.townImage.layer.cornerRadius = 37.5
        self.townImage.clipsToBounds = true
        
        
        //self.townImage.layer.borderWidth = 1.0
        //self.townImage.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
