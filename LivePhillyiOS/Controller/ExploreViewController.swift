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
import SkyFloatingLabelTextField

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var venues: [Venue]!
    
    @IBOutlet var searchInputField: SkyFloatingLabelTextFieldWithIcon!
    let url = "https://api.yelp.com/v3/businesses/search?location=philadelphia"
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer WhfBmynX0CW4OUEgzAFQHr7x5jG95kMe_RyRtkpb2D1KKsJ78ZObcrXYUbwp74CaJEHJY-LYlD_PGKXcR1c-073EiX7N9a9NsgqgBkP_GbguQQ2zHFKXuwY7nR06XHYx"
    ]
    
    
    @IBOutlet weak var exploreTableView: UITableView!
    
    override func viewDidLoad() {
        print("viewDidLoad")
        
        super.viewDidLoad()
        // MARK - search input field
        searchInputField.iconType = IconType.image
        searchInputField.delegate = self
        

        
        // MARK - table view initialization
        exploreTableView.delegate = self
        exploreTableView.dataSource = self
        exploreTableView.register(UINib(nibName: "ExploreTableViewCell", bundle:nil), forCellReuseIdentifier: "exploreTableViewCell")
        configureTableView()
        
        fetchData(searchTerm: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == searchInputField && searchInputField.text?.count ?? 0 > 0) {
            fetchData(searchTerm: searchInputField.text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchInputField.resignFirstResponder()
        return true
    }
    
    func fetchData(searchTerm: String?){
        HUD.show(.progress)
        var searchUrl: String
        if (searchTerm?.count ?? 0 > 0){
            let urlEncodedSearchTerm = searchInputField.text!.replacingOccurrences(of: " ", with: "+")
            searchUrl = url + "&categories=" + urlEncodedSearchTerm
        } else {
            searchUrl = url
        }
        print(" url = \(searchUrl))")
        Alamofire.request(searchUrl, method:.get, headers:headers).responseJSON {
            response in
            if response.result.isSuccess {
                self.venues = [Venue]()
                let json : JSON = JSON(response.result.value!)
                print("success retrieving data from yelp")
                
                print("looping through businesses in yelp response" )
                for (_, subJson) in json["businesses"] {
                    let decoder = JSONDecoder()
                    //                    do {
                    let data = try? subJson.rawData()
                    
                    let venue = try? decoder.decode(Venue.self, from: data!)
                    
                    if let venueToAppend = venue {
                        print("appending venue \(venue?.name ?? "no value found")")
                        self.venues.append(venueToAppend)
                    }
                }
                
                self.exploreTableView.reloadData()
            } else {
                // TODO error handling for UI
                print("error: \(String(describing: response.result.error ))" )
            }
            HUD.hide()
        }
    }
    
    
    
    
    // MARK: Table View Methods
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
