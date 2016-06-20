//
//  FovariteVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/26/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class FovariteVC: UIViewController {
    
    var myshowvc: ShowVC!
    var addlist: [String] = []
    @IBOutlet weak var tableFovarite: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "FOVARITE"
        self.navigationController?.navigationBar.barTintColor = uicolorFromHex(16729344)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        let nib = UINib(nibName: "ListtableView", bundle: nil)
        tableFovarite.registerNib(nib, forCellReuseIdentifier: "cell")
        tableFovarite.delegate = self
        
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FovariteVC: UITableViewDelegate,  UITableViewDataSource {
    
    // MARK: tableview
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addlist.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ListtableView = self.tableFovarite.dequeueReusableCellWithIdentifier("cell") as! ListtableView
        cell.nameList.text = addlist[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84
    }
}