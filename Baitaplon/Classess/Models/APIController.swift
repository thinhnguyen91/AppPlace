//
//  APIController.swift
//  Baitaplon
//
//  Created by ThinhNX on 6/14/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit
import MapKit



typealias APIControllerCallBack = (success: Bool, result: [Venue]?, error: NSError?) -> Void
typealias APIControllerImageCallback = (success: Bool, index: Int, imageListString: [PhotoVenue]?, error: NSError?) -> Void

class APIController: NSObject {
    
    var locationVenues = [LocationVenue]()
    var photoVenues = [PhotoVenue]()
    var place: Place!
    var places = [Place]()
    var venue: Venue!
    var venues = [Venue]()
    
    func getDataFromurl(url: String, complete: APIControllerCallBack?)  {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let data = data {
                self.extractJson(data, complete: { (success, result) -> Void in
                    if success {
                        complete?(success: success, result: result, error: error)
                    } else {
                        if let error = error {
                            complete?(success: false, result: nil, error: error)
                        }
                    }
                })
            }
            complete?(success: false, result: nil, error: error)
        })
        task.resume()
    }
    
    func extractJson(jsonData:NSData, complete: (success: Bool, result: [Venue]) -> Void) {
        do {
            if let dict = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? NSDictionary,
                let res = dict["response"] as? NSDictionary,
                let groups = res["groups"] as? NSArray {
                    for group in groups {
                        if let venu = group["items"] as? NSArray {
                            for index in venu {
                                if let ven = index["venue"] as? [String:AnyObject]{
                                    let obj = Venue(json: ven)
                                    self.venues.append(obj)
                                }
                            }
                        }
                        complete(success: true, result: self.venues)
                    }
            }
        } catch _ as NSError {
            complete(success: false, result: [])
        }
    }
    
    // MARK: jsonimage
    func getDataImageurl(url: String , index: Int, complete: APIControllerImageCallback?) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let data = data {
                self.extractJsonImage(data, complete: { (success, imageListString) -> Void in
                    if success {
                        print("______________\(index)          \(imageListString)")
                        complete?(success: success, index: index, imageListString: imageListString, error: nil)
                    }
                })
            }
            if let error = error {
                complete?(success: false, index: index, imageListString: nil, error: error)
            }
        })
        task.resume()
    }
    
    func extractJsonImage(jsonImage:NSData, complete: (success: Bool, imageListString: [PhotoVenue]) -> Void) {
        do {
            var photoVenues = [PhotoVenue]()
            if let dict = try NSJSONSerialization.JSONObjectWithData(jsonImage, options: []) as? NSDictionary,
                let res = dict["response"] as? NSDictionary,
                let photos = res["photos"] as? NSDictionary,let items = photos["items"] as? NSArray {
                    for item in items {
                        let images = PhotoVenue()
                        images.id = item["id"] as! String
                        images.prefix = item["prefix"] as! String
                        images.suffix = item["suffix"] as! String
                        images.width = item["width"] as! Int
                        images.height = item["height"] as! Int
                        photoVenues.append(images)
                    }
                    complete(success: true, imageListString: photoVenues)
            }
            
        } catch _ as NSError {
            complete(success: false, imageListString: [])
        }
    }
}
