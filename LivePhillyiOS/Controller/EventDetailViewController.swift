//
//  EventDetailViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 3/8/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import PKHUD

class EventDetailViewController: UIViewController {
    
    var event: FBEvent!

    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.progress)
        print(event.description)
        setupViews()
        HUD.hide()
        
        

        
    }
    
    func setupViews() {
        let url = URL(string: event.imageUrl)
        eventImageView.kf.setImage(with: url)
        eventTitleLabel.text = event.title
        eventDescriptionLabel.text = event.description
    }
    

    

}
