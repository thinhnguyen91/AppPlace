//
//  DetailVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 5/13/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var mySetting: SettingVC!
    var myListtableVC: ListtableView!
    var imageName : String?
    var buttonBack = UIButton()
    var imagePick = UIImagePickerController()
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var buttonImg: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DetailVC"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "barButtonItemClicked:"), animated: true)
        self.navigationItem.hidesBackButton = true
        self.imgAvatar.layer.cornerRadius = imgAvatar.frame.size.width / 2
        self.imgAvatar.clipsToBounds = true
        //custom button
        buttonBack.setImage(UIImage(named: "Back-25"), forState: .Normal)
        buttonBack.frame = CGRectMake(0, 0, 25, 25)
        buttonBack.setTitle("", forState: UIControlState.Normal)
        buttonBack.addTarget(self, action: Selector("back:"), forControlEvents: .TouchUpInside)
        let item = UIBarButtonItem()
        item.customView = buttonBack
        self.navigationItem.leftBarButtonItem = item
        if let image = UIImage(named: imageName!) {
            self.imgAvatar.image = image
        }
    }
    
    //MARK: ACTION
    
    @IBAction func kickButton(sender: AnyObject) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Swiftly Now! Choose an option!", preferredStyle: .ActionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in }
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            self.openCamera()
        }
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            self.openPicture()
        }
        actionSheetController.addAction(takePictureAction)
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(choosePictureAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK: IMAGE PIKER
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.imgAvatar.image = image;
        
    }
    
    func openPicture() {
        imagePick.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePick.delegate = self
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(imagePick, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            imagePick.sourceType = UIImagePickerControllerSourceType.Camera
            self .presentViewController(imagePick, animated: true, completion: nil)
            
        } else {
            print("No camera")
            // openPicture()
        }
    }
    
    func barButtonItemClicked(sender: UIBarButtonItem){
        print("kich edit")
    }
    
    func back(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
}
