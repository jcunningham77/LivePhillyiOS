//
//  EventDetailViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 3/8/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event: FBEvent!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(event.description)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
