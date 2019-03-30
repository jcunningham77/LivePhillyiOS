//
//  FBEvent.swift
//  LivePhillyiOS
//
//  Created by Jeff Cunningham on 3/5/19.
//  Copyright © 2019 Jeff Cunningham. All rights reserved.
//

import Foundation
import FirebaseFirestore
class FBEvent {
    
    let id: String

    let title, description: String
    let over21: Bool
    let attributes: [String]
    let reservationLink: String
    let imageUrl: String
    let phone, date: String
//    let venueName: String


    init (fromFB data: QueryDocumentSnapshot) {
        print(data);
        
        id = data.documentID;
        title = data.get("title") as? String ?? "" ;
        description = data.get("description") as? String ?? "" ;
        reservationLink = data.get("reservationLink") as? String ?? "" ;
        imageUrl = data.get("imageUrl") as? String ?? "" ;
        phone = data.get("phone") as? String ?? "" ;
        date = data.get("date") as? String ?? "" ;
        over21 = data.get("over21") as? Bool ?? false ;
        
        let eventVenueNameFieldPath = FieldPath(["eventVenue","location","name"])
        let eventVenueName = data.get(eventVenueNameFieldPath)
        
        // USE THS 
        data.get("eventVenue") as? NSDictionary
        
        
        attributes = ["Breakfast","Lunch"];
    }

}
