//
//  Venue.swift
//  Baitaplon
//
//  Created by ThinhNX on 6/17/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class Venue: NSObject {
    var id = ""
    var name = ""
    var rating: Float = 0.0
    var location: LocationVenue?
    var photos: [PhotoVenue]?
    var isFovarite = false
    
    init (json: [String : AnyObject]) {
        id = json["id"] as? String ?? ""
        name = json["name"] as? String ?? ""
        rating = json["rating"] as? Float ?? 0.0
        if let locationDictionary = json["location"] {
            self.location = LocationVenue(json: locationDictionary as! [String : AnyObject])
        }
    }

}
