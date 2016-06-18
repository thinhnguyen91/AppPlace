 //  HomeVC.swift
 //  Baitaplon
 //
 //  Created by ThinhNX on 4/26/16.
 //  Created by ThinhNX on 5/13/16.
 //  Copyright © 2016 AsianTech. All rights reserved.
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
                    //                    for i in self.places {
                    //                        let id = i.id
                    //                        api.getDataImageurl(id, complete: { (success, imageListString, error) -> Void in
                    //                            i.photo = imageListString
                    //                            if i.last {
                    //                                tablereloaddata
                    //                            }
                    //                        })
                    //                    }
                    api.getDataImageurl(AppDefine.urlImage) { (success, imageListString, error) -> Void in
                        if success {
                            if let imageListString = imageListString {
                                self.photoVenues = imageListString
                            }
                            self.tableView.reloadData()
                        } else {
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let photo = photoVenues[indexPath.row]
      
        cell.nameList.text = venue.name
        cell.addessList.text = venue.location?.address ?? ""
        cell.imageList.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "\(photo.getURLPath(300, sizeH: 200))")!)!)
        
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = venues[indexPath.row]
        let myshowVC = ShowVC(nibName: "ShowVC", bundle: nil)
        myshowVC.photoVenues = self.photoVenues
        myshowVC.venue = item
        
        self.navigationController?.pushViewController(myshowVC, animated: true)
        print("Cell \(indexPath.row) of Section \(indexPath.section) ")
    }


 }
 
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
