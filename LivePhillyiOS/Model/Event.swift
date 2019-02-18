// To parse the JSON, add this file to your project and do:
//
//   let event = try? newJSONDecoder().decode(Event.self, from: jsonData)

import Foundation

class Event: Codable {
    let id: String
    let index: Int
    let title, description: String
    let over21: Bool
    let address: Address
    let venue: EventVenue
    let price: Price
    let categories: [String]
    let reservationLink: String
    let imageURL: String
    let phone, date: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case index, title, description, over21, address, venue, price, categories, reservationLink
        case imageURL = "imageUrl"
        case phone, date
    }
    
    init(id: String, index: Int, title: String, description: String, over21: Bool, address: Address, venue: EventVenue, price: Price, categories: [String], reservationLink: String, imageURL: String, phone: String, date: String) {
        self.id = id
        self.index = index
        self.title = title
        self.description = description
        self.over21 = over21
        self.address = address
        self.venue = venue
        self.price = price
        self.categories = categories
        self.reservationLink = reservationLink
        self.imageURL = imageURL
        self.phone = phone
        self.date = date
    }
}

class Address: Codable {
    let line1, line2, city, state: String
    let zip: Int
    let country: String
    
    init(line1: String, line2: String, city: String, state: String, zip: Int, country: String) {
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
    }
}

class Price: Codable {
    let amount, currency: String
    
    init(amount: String, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}

class EventVenue: Codable {
    let yelpID, name: String
    
    enum CodingKeys: String, CodingKey {
        case yelpID = "yelpId"
        case name
    }
    
    init(yelpID: String, name: String) {
        self.yelpID = yelpID
        self.name = name
    }
}
