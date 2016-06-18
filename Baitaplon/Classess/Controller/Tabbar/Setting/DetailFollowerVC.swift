//
//  DetailFollowerVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 5/16/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit
import MapKit
class DetailFollowerVC: UIViewController {
    var places = [Place]()
    var venues = [Venue]()
    var list: ListtableView!
    var btn = UIButton()
    @IBOutlet weak var tableDetailFollower: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DetailFollowerVC"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = true
        
        //custom button
        btn.setImage(UIImage(named: "Back-25"), forState: .Normal)
        btn.frame = CGRectMake(0, 0, 25, 25)
        btn.titleLabel?.text = ""
        btn.addTarget(self, action: Selector("back:"), forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem()
        item.customView = btn
        self.navigationItem.leftBarButtonItem = item
        
        let nib = UINib(nibName: "Cell", bundle: nil)
        tableDetailFollower.registerNib(nib, forCellReuseIdentifier: "Cell")
        
//        for var i = 0 ; i <= 10 ; i++ {
//            
//            let place = Place(title: "",
//                locationName: "",
//                discipline: "",
//                coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
//            if i%2 == 0 {
//                place.name = "Nam"
//            } else {
//                place.name = "Nu"
//            }
//            place.avatar  = "nhahang\(i%6)"
//            place.phone = 0124557635+i
//            places.append(place)
//        }
        
        let barButton = UIBarButtonItem(image: UIImage(named: "delete25"), landscapeImagePhone: nil, style: .Done, target: self, action:  Selector("action:"))
        
        self.navigationItem.rightBarButtonItem = barButton
        
        self.tableDetailFollower.delegate = self
        self.tableDetailFollower.dataSource = self
        
    }
    func back(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    func action(sender: UIBarButtonItem){
        let alert = UIAlertController(title: "DELETE ALL", message: "Would you like to continue Delete all?", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ (actionSheetController) -> Void in
            print("handle Save action...")
            self.places.removeAll()
            self.tableDetailFollower.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // MARK: tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ListtableView = self.tableDetailFollower.dequeueReusableCellWithIdentifier("Cell") as! ListtableView
        let place = places[indexPath.row]
        let imageview: UIImage = UIImage(named: place.avatar)!
        
        cell.avatar.image = imageview
       // cell.nameLable.text = place.name
        cell.phoneLable.text = String(place.phone)
        //cell.phoneLable.hidden = true
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 48
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableDetailFollower.deselectRowAtIndexPath(indexPath, animated: true)
        
        let item = places[indexPath.row]
        let myShowDetailVC = ShowDetailVC(nibName: "ShowDetailVC", bundle: nil)
        myShowDetailVC.place = item
        self.navigationController?.pushViewController(myShowDetailVC, animated: true)
        
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            places.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
extension DetailFollowerVC: UITableViewDelegate,  UITableViewDataSource{
 
}