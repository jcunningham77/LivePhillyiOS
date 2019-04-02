//
//  EventDetailViewController.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 3/8/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import UIKit
import PKHUD
import Firebase
import CoreData


class EventDetailViewController: UIViewController {
    
    var event: FBEvent!
    var db = Firestore.firestore()
    var isRSVPd = false
    
    @IBOutlet var venueLocationLabel: UILabel!
    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!
    @IBOutlet var rsvpEventImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.progress)
        print(event.description)
        setupViews()
        fetchRsvpSetting()
        HUD.hide()
    }
    
    func setupViews() {
        let url = URL(string: event.imageUrl)
        eventImageView.kf.setImage(with: url)
        eventTitleLabel.text = event.title
        eventDescriptionLabel.text = event.description
        
        //build location label
        var locationLabelText: String
        locationLabelText = event.venueDictionary.object(forKey: "name") as? String ?? ""
        let venueLocationDictionary = event.venueDictionary.object(forKey: "location") as? NSDictionary
        for addressField in venueLocationDictionary?.object(forKey: "display_address") as? [String] ?? [String](){
            locationLabelText = locationLabelText + ", " + addressField
        }
        venueLocationLabel.text = locationLabelText
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(EventDetailViewController.rsvpClicked))
        rsvpEventImage.isUserInteractionEnabled = true
        rsvpEventImage.addGestureRecognizer(singleTap)
    }
    
    func fetchRsvpSetting(){
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            let uid = user!.uid
            var rsvpRef: CollectionReference? = nil
            rsvpRef = db.collection("rsvp")
            
            let rsvpQuery = rsvpRef?.whereField("eventId", isEqualTo: event.id)
                .whereField("userId", isEqualTo: uid)
            
            rsvpQuery?.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting rsvp: \(err)")
                } else {
                    if (querySnapshot?.documents.count ?? 0 > 0){
                        print("rsvp found for this user in the database, updating RSVP Icon to on")
                        self.rsvpEventImage.image = UIImage(named: "rsvp_on")!
                    } else {
                        print("no rsvp found for this user in the database, updating RSVP Icon to off")
                        self.rsvpEventImage.image = UIImage(named: "rsvp_off")!
                    }
                }
            }
        }
    }
    
    @objc func rsvpClicked() {
        print("rsvpClicked")
        HUD.show(.progress)
        if Auth.auth().currentUser != nil {
            print("rsvpClicked - current user is not nil")
            let user = Auth.auth().currentUser
            let uid = user!.uid
            
            isRSVPd = !isRSVPd
            if (isRSVPd){
                print("rsvpClicked - is rsvp == true")
                rsvpEventImage.image = UIImage(named: "rsvp_on")!
                
                var ref: DocumentReference? = nil
                
                ref = db.collection("rsvp")
                        .addDocument(data: [
                            "eventId" : event.id,
                            "userId" : uid ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        
                        // persist the RSVP record to the database
                        var storedRSVPs: [NSManagedObject] = []
                        
                        guard let appDelegate =
                            UIApplication.shared.delegate as? AppDelegate else {
                                return
                        }
                        // 1
                        let managedContext =
                            appDelegate.persistentContainer.viewContext
                        
                        // 2
                        let entity =
                            NSEntityDescription.entity(forEntityName: "RSVP",
                                                       in: managedContext)!
                        
                        let rsvp = NSManagedObject(entity: entity,
                                                     insertInto: managedContext)
                        
                        rsvp.setValue(self.event.id, forKeyPath: "event_id")
                        rsvp.setValue(ref!.documentID, forKeyPath: "rsvp_id")
                        
                        let venueId = self.event.venueDictionary.object(forKey: "id") as? String ?? ""
                        rsvp.setValue(venueId, forKeyPath: "venue_id")
                        
                        let coordinatesDictionary = self.event.venueDictionary.object(forKey: "coordinates") as? NSDictionary
                        
                        let latitude = coordinatesDictionary?.object(forKey: "latitude") as? Float ?? Float()
                        let longitude = coordinatesDictionary?.object(forKey: "longitude") as? Float ?? Float()
                        
                        rsvp.setValue(latitude, forKeyPath: "latitude")
                        rsvp.setValue(longitude, forKeyPath: "longitude")
                        
                        
                        // fetch existing rsvp's to append to
                        let fetchRequest =
                            NSFetchRequest<NSManagedObject>(entityName: "RSVP")
                        
                        //3
                        do {
                            storedRSVPs = try managedContext.fetch(fetchRequest)
                        } catch let error as NSError {
                            print("Could not fetch. \(error), \(error.userInfo)")
                        }
                        
                        // 4
                        do {
                            try managedContext.save()
                            storedRSVPs.append(rsvp)
                        } catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                    }
                }
            } else {
                rsvpEventImage.image = UIImage(named: "rsvp_off")!
                db.collection("rsvp")
                    .whereField("eventId", isEqualTo: event.id)
                    .whereField("userId", isEqualTo: uid)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                document.reference.delete()
                            }
                        }
                }
            }
        }
        HUD.hide()
    }
}
