//
//  MyEventsViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 3/31/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import Firebase

import PKHUD


class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet var myEventsTableView: UITableView!
    
    var db = Firestore.firestore()
    
    var events = [FBEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myEventsTableView.delegate = self
        myEventsTableView.dataSource = self
        fetchData()
        
    }
    
    func fetchData(){
        HUD.show(.progress)
        let userID = Auth.auth().currentUser?.uid
        db.collection("rsvp").whereField("userId", isEqualTo: userID ?? "").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
//                self.events = [FBEvent]()
                for rsvpDocument in querySnapshot!.documents {
                    print("eventid = \(rsvpDocument.get("eventId") as? String ?? "")")
                    let eventId = rsvpDocument.get("eventId") as? String ?? ""
                    
                    self.db.collection("events").document(eventId).getDocument() { (documentSnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            let eventToAppend: FBEvent
                            if let document = documentSnapshot {
                                eventToAppend = FBEvent(fromFB: document)
                                print("appending event = " + eventToAppend.title)
                                self.events.append(eventToAppend)
                                print("calling reload data after loading \(self.events.count)event")
                                
                                self.myEventsTableView.reloadData()
                            }
                        }
                    }
                }
            }
            
            HUD.hide()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        
        return events.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        
        // Configure the cell’s contents with the row and section number.
        cell?.textLabel!.text = events[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}
