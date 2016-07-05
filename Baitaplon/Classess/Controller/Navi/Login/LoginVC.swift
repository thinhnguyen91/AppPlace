 //
//  LoginVC.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/26/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    // MARK: action
    @IBAction func forgotBT(sender: AnyObject) {
        
        let forgotVC = ForgotPasswordVC(nibName: "ForgotPasswordVC", bundle: nil)
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    @IBAction func registBT(sender: AnyObject) {
        
        let registerVC = RegisterVC(nibName: "RegisterVC", bundle: nil)
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "LOGIN"
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = uicolorFromHex(16729344)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "login:")
        self.userText.delegate = self
        self.passText.delegate = self
        self.passText.secureTextEntry = true
    }
    
    func login(sender: UIBarButtonItem) {
        let user:NSString = "xuanthinh"
        let pass:NSString = "123"
        if userText.text == user && passText.text == pass {
            AppDelegate.sharedInstance().loginSuccess()
            print("login")
        } else if userText.text == user && passText.text != pass {
                let alert = UIAlertController(title: "Error!",
                    message: "Please enter a password!",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        } else if userText.text != user && passText.text == pass {
                let alert = UIAlertController(title: "Error!",
                    message: "Please enter a email !",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        } else if userText.text != user && passText.text != pass {
                let alert = UIAlertController(title: "Error!",
                    message: "Please enter a email and password !",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        }
        if userText.text == "" && passText.text == "" {
                let alert = UIAlertController(title: "Error!",
                    message: "Please enter a email and password !",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        } else if passText.text == "" && userText.text != "" {
                let alert = UIAlertController(title: "Error!",
                    message: "Please enter a password!",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        } else if passText.text != "" && userText.text == "" {
                let alert = UIAlertController(title: "Error!",
                    message: "Please enter a email !",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: toucher textfiled
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension LoginVC: UITextFieldDelegate{
    
}
