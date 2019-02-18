//
//  EventViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 2/18/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class EventViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var events: [Event]!
    
    @IBOutlet var eventTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.register(UINib(nibName: "EventTableViewCell", bundle:nil), forCellReuseIdentifier: "eventTableViewCell")
        
        configureTableView()
        
        let url = Bundle.main.url(forResource: "eventDataGenerated", withExtension: "json")!
        
        do {
            let jsonData = try Data(contentsOf: url)
            self.events = [Event]()
            
            let json : JSON = JSON(jsonData)
            
            var i: Int = 0
            for (_, subJson) in json["events"] {
                i = i+1
                let decoder = JSONDecoder()
                //                    do {
                let data = try? subJson.rawData()
                
                let event = try? decoder.decode(Event.self, from: data!)
                
                if let eventToAppend = event {
                    if (i <= 2){
                        self.events.append(eventToAppend)
                    }
                    
                }
            }
            
            self.eventTableView.reloadData()
            self.eventTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            var frame = CGRect.zero
            frame.size.height = .leastNormalMagnitude
            self.eventTableView.tableHeaderView = UIView(frame: frame)
            self.eventTableView.tableFooterView = UIView(frame: frame)
        } catch {
            print("error reading from JSON file \(error)")
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = events {
            print("numberOfRowsInSection = returning \(events.count)")
            return events.count
        } else {
            print("numberOfRowsInSection = returning 0")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier:"eventTableViewCell", for: indexPath) as! EventTableViewCell
        
        
        cell.eventTitleLabel.text = events[indexPath.row].title
        let displayAddressText = events[indexPath.row].address.line1
        cell.eventLocationLabel.text = displayAddressText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:events[indexPath.row].date)!
        
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        
        
        
        cell.eventDateLabel.text = day + month
        
        // TODO add error handling for string URL
        //        let urlString = events[indexPath.row].imageURL
        //        print("string url = " + urlString)
        //        let url = URL(string: urlString)
        
        let imageName: String
        
        switch indexPath.row {
        case  0:
            imageName = "wine.png"
        case  1:
            imageName = "escape.png"
        case  2:
            imageName = "concert.png"
        case  3:
            imageName = "banquet.png"
        default:
            imageName = "wine.png"
        }
        cell.eventImageView.image = UIImage(named: imageName)!
        
        return cell
    }
    
    func configureTableView(){
        eventTableView.rowHeight = UITableView.automaticDimension
        eventTableView.estimatedRowHeight = 300
    }
}
