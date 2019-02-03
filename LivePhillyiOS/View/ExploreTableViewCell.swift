//
//  ExploreTableViewCell.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 2/3/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
