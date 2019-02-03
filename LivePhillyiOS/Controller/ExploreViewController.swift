//
//  ExploreTVController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 2/2/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let url = "https://api.yelp.com/v3/businesses/search?location=philadelphia&categories=bubbletea"
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer WhfBmynX0CW4OUEgzAFQHr7x5jG95kMe_RyRtkpb2D1KKsJ78ZObcrXYUbwp74CaJEHJY-LYlD_PGKXcR1c-073EiX7N9a9NsgqgBkP_GbguQQ2zHFKXuwY7nR06XHYx"
    ]

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        Alamofire.request(url, method:.get, headers:headers).responseJSON {
            response in
            if response.result.isSuccess {
                
                let results : JSON = JSON(response.result.value!)
                print("success, results data: \(results)")
                
            } else {
                print("error: \(response.result.error)" )
                
            }
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"customMessageCell", for: indexPath) 
            
            return cell
    }

  

}
