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
    
    @IBOutlet var titleView: UINavigationItem!
    
    
    var venues: [Venue]!
    
    let url = "https://api.yelp.com/v3/businesses/search?location=philadelphia&categories=bubbletea"
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer WhfBmynX0CW4OUEgzAFQHr7x5jG95kMe_RyRtkpb2D1KKsJ78ZObcrXYUbwp74CaJEHJY-LYlD_PGKXcR1c-073EiX7N9a9NsgqgBkP_GbguQQ2zHFKXuwY7nR06XHYx"
    ]
    
    
    @IBOutlet var logout: UIBarButtonItem!
    @IBOutlet weak var exploreTableView: UITableView!
    
    @objc func logoutFunc(){
        print("logout")
    }
    
    

    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        
        self.titleView.rightBarButtonItem = logout
//        logout.action: #selector(self.logoutFunc())
        
        logout!.action = #selector(logoutFunc())
        
        exploreTableView.delegate = self
        exploreTableView.dataSource = self
        exploreTableView.register(UINib(nibName: "ExploreTableViewCell", bundle:nil), forCellReuseIdentifier: "exploreTableViewCell")
        
        configureTableView()
        
        Alamofire.request(url, method:.get, headers:headers).responseJSON {
            response in
            if response.result.isSuccess {
                self.venues = [Venue]()
                
                let json : JSON = JSON(response.result.value!)
                print("success, results data: \(json)")
                print("looping through businesses in yelp response" )
                for (_, subJson) in json["businesses"] {
                    let venue = Venue ()
                    if let name = subJson["name"].string {
                        venue.name = name
                    }
                    if let address = subJson["address"].string {
                        venue.address = address
                    }
                    if let image_url = subJson["image_url"].string {
                        venue.imageUrl = image_url
                    }
                    self.venues.append(venue)
                    
                }
                
                self.exploreTableView.reloadData()
                
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
        if let venues = venues {
            print("numberOfRowsInSection = returning zero\(venues.count)")
            return venues.count
        } else {
            print("numberOfRowsInSection = returning 0")
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier:"exploreTableViewCell", for: indexPath) as! ExploreTableViewCell
        cell.nameLabel.text = venues[indexPath.row].name
        cell.addressLabel.text = venues[indexPath.row].name
        //            cell.venueImage = venues[indexPath.row].name
        return cell
    }
    
    func configureTableView(){
        exploreTableView.rowHeight = UITableView.automaticDimension
        exploreTableView.estimatedRowHeight = 70
    }
    
    
    
}
