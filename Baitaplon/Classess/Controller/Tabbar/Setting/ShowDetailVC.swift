//
//  ShowDetailVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 5/23/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit


class ShowDetailVC: UIViewController {
    var buttonBack = UIButton()
    var buttonHome = UIButton()
    var place: Place!
    var venue: Venue!
    
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = venue.name
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = true
        //custom button uibaritem
        buttonHome.setImage(UIImage(named: "List-25"), forState: .Normal)
        buttonHome.frame = CGRectMake(0, 0, 25, 25)
        buttonHome.addTarget(self, action: Selector("backhome:"), forControlEvents: .TouchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = buttonHome
        self.navigationItem.rightBarButtonItem = item1
        buttonBack.setImage(UIImage(named: "Back-25"), forState: .Normal)
        buttonBack.frame = CGRectMake(0, 0, 25, 25)
        buttonBack.titleLabel?.text = ""
        buttonBack.addTarget(self, action: Selector("back:"), forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem()
        item.customView = buttonBack
        self.navigationItem.leftBarButtonItem = item
        self.imgShow.layer.cornerRadius = imgShow.frame.size.width / 2
        self.imgShow.clipsToBounds = true
        self.textName.delegate = self
        self.phoneText.delegate = self
        self.textName.text = venue.name
        self.phoneText.text = String(place.phone)
        self.imgShow.image = UIImage(named: place.avatar)
    }
    
    func backhome (sender: UIBarButtonItem){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func back(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ShowDetailVC: UITextFieldDelegate{
    
}