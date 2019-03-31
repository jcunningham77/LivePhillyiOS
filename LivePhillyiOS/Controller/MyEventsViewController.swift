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


class MyEventsViewController: UIViewController {
    
    
    var db = Firestore.firestore()
    
    var events: [FBEvent]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
    }
    
    func fetchData(){
        HUD.show(.progress)
        let userID = Auth.auth().currentUser?.uid
        db.collection("rsvp").whereField("userId", isEqualTo: userID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for rsvpDocument in querySnapshot!.documents {
                    print("eventid = \(rsvpDocument.get("eventId") as? String ?? "")")
                    let eventId = rsvpDocument.get("eventId") as? String ?? ""
                    
                    db.collection("events").document(eventId) { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            self.events = [FBEvent]()
                            for document in querySnapshot!.documents {
                                let eventToAppend: FBEvent
                                
                                eventToAppend = FBEvent(fromFB: document)
                                print("appending event, " + eventToAppend.description)
                                self.events.append(eventToAppend)
                            }
                        }
                    }
                    
                }
                HUD.hide()
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
        
        //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return
        //    }
        //
        //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        //    }
        
    }
}
