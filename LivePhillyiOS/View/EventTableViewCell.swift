//
//  EventTableViewCell.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 2/18/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var eventDateLabel: UILabel!
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var eventLocationLabel: UILabel!
    @IBOutlet var eventTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventDateLabel.layer.cornerRadius =  eventDateLabel.frame.width/2
        eventDateLabel.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
