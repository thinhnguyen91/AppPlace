//
//  LocationVenue.swift
//  Baitaplon
//
//  Created by ThinhNX on 6/14/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class LocationVenue: NSObject {
    var address = ""
    var lat:Double = 0
    var long:Double = 0
    var distance = 0
    var cc = ""
    var city = ""
    var state = ""
    var country = ""
    init (json: [String : AnyObject]) {
        self.address = json["address"] as? String ?? ""
        self.cc = json["cc"] as? String ?? ""
        self.country = json["country"] as? String ?? ""
        self.lat = json["lat"] as? Double ?? 0
        self.long = json["lng"] as? Double ?? 0
        self.distance = json["distance"] as? Int ?? 0
        
    }

}
