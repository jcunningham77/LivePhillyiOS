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
import Kingfisher
import PKHUD

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var venues: [Venue]!
    
    let url = "https://api.yelp.com/v3/businesses/search?location=philadelphia&categories=bubbletea"
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer WhfBmynX0CW4OUEgzAFQHr7x5jG95kMe_RyRtkpb2D1KKsJ78ZObcrXYUbwp74CaJEHJY-LYlD_PGKXcR1c-073EiX7N9a9NsgqgBkP_GbguQQ2zHFKXuwY7nR06XHYx"
    ]
    
    
    @IBOutlet weak var exploreTableView: UITableView!
    
    override func viewDidLoad() {
        print("viewDidLoad")
        HUD.show(.progress)
        super.viewDidLoad()
        
        
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
                    let decoder = JSONDecoder()
                    //                    do {
                    let data = try? subJson.rawData()
                    
                    let venue = try? decoder.decode(Venue.self, from: data!)
                    
                    if let venueToAppend = venue {
                        self.venues.append(venueToAppend)
                    }
                    
                }
                HUD.hide()
                self.exploreTableView.reloadData()
            } else {
                print("error: \(String(describing: response.result.error ))" )
            }
        }
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
        let displayAddressText = venues[indexPath.row].location.displayAddress[0] + ", " + venues[indexPath.row].location.displayAddress[1];
        cell.addressLabel.text = displayAddressText
        let urlString = URL(string: venues[indexPath.row].imageURL.replacingOccurrences(of: "o.jpg", with: "120s.jpg"))
        cell.venueImage.kf.setImage(with: urlString)
        return cell
    }
    
    func configureTableView(){
        exploreTableView.rowHeight = UITableView.automaticDimension
        exploreTableView.estimatedRowHeight = 70
    }
}
