//
//  ShowDetailVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 5/23/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit


class ShowDetailVC: UIViewController {
    var btn = UIButton()
    var btn1 = UIButton()
    var place: Place!
    
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var phoneText: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = place.name
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.hidesBackButton = true
        
        //custom button uibaritem
        btn1.setImage(UIImage(named: "List-25"), forState: .Normal)
        btn1.frame = CGRectMake(0, 0, 25, 25)
        btn1.addTarget(self, action: Selector("backhome:"), forControlEvents: .TouchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = btn1
        self.navigationItem.rightBarButtonItem = item1
        
        btn.setImage(UIImage(named: "Back-25"), forState: .Normal)
        btn.frame = CGRectMake(0, 0, 25, 25)
        btn.titleLabel?.text = ""
        btn.addTarget(self, action: Selector("back:"), forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem()
        item.customView = btn
        self.navigationItem.leftBarButtonItem = item
        
        self.imgShow.layer.cornerRadius = imgShow.frame.size.width / 2
        self.imgShow.clipsToBounds = true
        
        self.textName.delegate = self
        self.phoneText.delegate = self
        
        self.textName.text = place.name
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