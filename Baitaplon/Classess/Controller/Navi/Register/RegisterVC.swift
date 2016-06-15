//
//  RegisterVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/26/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    var btn = UIButton()
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userRegi: UITextField!
    @IBOutlet weak var passRegi: UITextField!
    @IBOutlet weak var newpassRegi: UITextField!
    @IBOutlet weak var emailRegi: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "REGISTER"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "done:")
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollEnabled = true
        scrollView.delegate = self
        scrollView.contentSize.height = 700
        
        //custom button
        btn.setImage(UIImage(named: "Back-25"), forState: .Normal)
        btn.frame = CGRectMake(0, 0, 25, 25)
        btn.setTitle("", forState: UIControlState.Normal)
        btn.addTarget(self, action: Selector("back:"), forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem()
        item.customView = btn
        self.navigationItem.leftBarButtonItem = item
        
        self.avatar.layer.cornerRadius = avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
        
        self.userRegi.delegate = self
        self.passRegi.delegate = self
        self.newpassRegi.delegate = self
        self.emailRegi.delegate = self
        
    }
    func done(sender: UIBarButtonItem){
        AppDelegate.sharedInstance().loginSuccess()
        print("done")
        
    }
    func back(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    //MARK: toucher textfiled
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RegisterVC: UITextFieldDelegate, UIScrollViewDelegate  {
    
}