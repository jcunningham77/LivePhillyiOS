//
//  EventViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 2/18/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase
import Kingfisher
import PKHUD

class EventViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    var events: [FBEvent]!
    
    @IBOutlet var eventTableView: UITableView!
    
    override func viewDidLoad() {
        HUD.show(.progress)
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.register(UINib(nibName: "EventTableViewCell", bundle:nil), forCellReuseIdentifier: "eventTableViewCell")
        
        configureTableView()
        let db = Firestore.firestore()
        
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.events = [FBEvent]()
                for document in querySnapshot!.documents {
                    print(document)
                    let eventToAppend: FBEvent
                    
                    eventToAppend = FBEvent(fromFB: document)
                    self.events.append(eventToAppend)
                }
                
                self.eventTableView.reloadData()
                HUD.hide()
            }
        }
        
        self.eventTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        self.eventTableView.tableHeaderView = UIView(frame: frame)
        self.eventTableView.tableFooterView = UIView(frame: frame)
    }
    
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:events[indexPath.row].date)
        
        if let dateParsed = date {
            dateFormatter.dateFormat = "MM"
            let month = dateFormatter.string(from: dateParsed)
            dateFormatter.dateFormat = "dd"
            let day = dateFormatter.string(from: dateParsed)
            cell.eventDateLabel.text = day + month
        } else {
            cell.eventDateLabel.text = "TBD"
        }
        
        let url = URL(string: events[indexPath.row].imageUrl)
        cell.eventImageView.kf.setImage(with: url)
        return cell
    }
    
    func configureTableView(){
        eventTableView.rowHeight = UITableView.automaticDimension
        eventTableView.estimatedRowHeight = 300
    }
}
