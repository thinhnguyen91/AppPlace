
// HomeVC.swift
// Baitaplon
//
// Created by ThinhNX on 4/26/16.
// Created by ThinhNX on 5/13/16.
// Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    var tabBar: UITabBar?
    var place: Place!
    var venue: Venue!
    var venues = [Venue]()
    var places = [Place]()
    var locationVenues = [LocationVenue]()
    var photoVenues = [PhotoVenue]()
    var myShowVC = ShowVC()
    var searchResultsData: NSArray = []
    @IBOutlet weak var tableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "HOME"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = uicolorFromHex(16729344)
        self.navigationController?.navigationBar.translucent = true
        let nib = UINib(nibName: "ListtableView", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cell")
        //tabbar
        tabBar = self.tabBarController!.tabBar
        tabBar!.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(uicolorFromHex(16777215),
            size: CGSizeMake(tabBar!.frame.width/CGFloat(tabBar!.items!.count), tabBar!.frame.height))
        // To change tintColor for unselect tabs
        for item in tabBar!.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(uicolorFromHex(16777215)).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        let api = APIController()
        api.getDataFromurl(AppDefine.url) { (success, result, error) -> Void in
            if !success {
                if let error = error {
                    print(error.localizedDescription)
                }
            } else {
                if let result = result {
                    self.venues = result
                    let venue = self.venues[0]
                    let url = AppDefine.urlImageEndPoint + venue.id + AppDefine.urlImageOauth_token
                    print(url)
                }
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), { () -> Void in
                    for i in 0 ..< self.venues.count {
                        let vn: Venue = self.venues[i]
                        let url = AppDefine.urlImageEndPoint + vn.id + AppDefine.urlImageOauth_token
                        api.getDataImageurl(url, index: i) { (success, index, imageListString, error) -> Void in
                            if success {
                                if let imageListString = imageListString {
                                    self.venues[index].photos = imageListString
                                }
                                if index == self.venues.count - 1 {
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        self.tableView.reloadData()
                                    })
                                }
                            } else {
                                if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                })
            }
        }
    }
    private func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
 }

 extension HomeVC: UITableViewDelegate,  UITableViewDataSource {
    
    // MARK: tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ListtableView = self.tableView.dequeueReusableCellWithIdentifier("cell") as! ListtableView
        let venue = venues[indexPath.row]
        if let photos = venue.photos {
            let photo = photos[0]
            cell.imageList.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "\(photo.getURLPath(300, sizeH: 200))")!)!)
        }
        cell.nameList.text = venue.name
        cell.addessList.text = venue.location?.address ?? ""
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = venues[indexPath.row]
        let myshowVC = ShowVC(nibName: "ShowVC", bundle: nil)
        myshowVC.venue = item
        self.navigationController?.pushViewController(myshowVC, animated: true)
        print("Cell \(indexPath.row) of Section \(indexPath.section) ")
    }

}
//extension HomeVC: UITableViewDelegate, UITableViewDataSource {

//    func getDataFromurl(url: String) {
//
//        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        let session = NSURLSession.sharedSession()
//        request.HTTPMethod = "GET"
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            self.extractJson(data!)
//        })
//        task.resume()
//    }
//
//    func extractJson(jsonData:NSData) {
//        do {
//            if let dict = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? NSDictionary,
//                let res = dict["response"] as? NSDictionary,
//                let groups = res["groups"] as? NSArray {
//                    for group in groups {
//                        if let venu = group["items"] as? NSArray {
//                            for index in venu {
//                                if let ven = index["venue"] as? [String:AnyObject]{
//                                    let obj = Place(title: "", locationName: "", discipline: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), json: ven)
//                                    self.places.append(obj)
//
//                                    if let loca = ven["location"] as? [String:AnyObject] {
//                                        let location = LocationVenue(json: loca)
//                                        self.locationVenues.append(location)
//                                    }
//
//
//
//                                }
//
//                            }
//
//                        }
//
//                    }
//            }
//            self.tableRefresh()
//
//        } catch let jsonError as NSError {
//            print(jsonError)
//        }
//
//    }
//    // MARK: jsonimage
//    func getDataImageurl(url: String) {
//
//        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        let session = NSURLSession.sharedSession()
//        request.HTTPMethod = "GET"
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            self.extractJsonImage(data!)
//        })
//        task.resume()
//    }
//
//    func extractJsonImage(jsonImage:NSData) {
//        do {
//            if let dict = try NSJSONSerialization.JSONObjectWithData(jsonImage, options: []) as? NSDictionary,
//                let res = dict["response"] as? NSDictionary,
//                let photos = res["photos"] as? NSDictionary,let items = photos["items"] as? NSArray {
//                    for item in items {
//                        let images = PhotoVenue()
//                        images.id = item["id"] as! String
//                        images.prefix = item["prefix"] as! String
//                        images.suffix = item["suffix"] as! String
//                        images.width = item["width"] as! Int
//                        images.height = item["height"] as! Int
//
//                        self.photoVenues.append(images)
//                    }
//                    print(photoVenues)
//            }
//            self.tableRefresh()
//
//        } catch let jsonError as NSError {
//            print(jsonError)
//        }
//
//    }
//       func tableRefresh()
//    {
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tableView.reloadData()
//            return
//        })
//    }
//
//}

 extension UIImage {

    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        return newImage
    }

}
