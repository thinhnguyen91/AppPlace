//
//  List.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/27/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit
import MapKit
class Place: NSObject, MKAnnotation{
   
    var avatar: String = ""
    var start: String = ""
    var startyellow: String = ""
    var name: String = ""
    var phone: Int = 0
    var location: LocationVenue?
    
    var image: UIImage?
    var title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    var index = 0
    var isFovarite = false
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, json: [String : AnyObject]) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.name = json["name"] as? String ?? ""
        self.title = json["address"] as? String ?? ""
        if let locationDictionary = json["location"] {
            self.location = LocationVenue(json: locationDictionary as! [String : AnyObject])
        }
        super.init()
    }
    
 

    var subtitle: String? {
        return locationName
    }
}
