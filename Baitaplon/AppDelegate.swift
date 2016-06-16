//
//  AppDelegate.swift
//  Baitaplon
//
//  Created by ThinhNX on 4/26/16.
//  Copyright © 2016 AsianTech. All rights reserved.
//

import UIKit

//text pull request

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation: UINavigationController?
    var tabbar: UITabBarController?
    
    class func sharedInstance() -> AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
       
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont(name: "American Typewriter", size: 13)!,
            NSForegroundColorAttributeName: uicolorFromHex(16777215)],
            forState: UIControlState.Normal)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //init navigation controller
        // init LoginVC
        
        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
        navigation = UINavigationController(rootViewController: loginVC)
        
        // init tabbar
        
        // navi Home
        let nav1 = UINavigationController()
        let homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
        nav1.viewControllers = [homeVC]
        nav1.title = "HOME"
        nav1.tabBarItem.image = UIImage(named: "Home_2")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //navi favorite
        let nav2 = UINavigationController()
        let favoriteVC = FovariteVC(nibName: "FovariteVC", bundle: nil)
        nav2.viewControllers = [favoriteVC]
        nav2.title = "FOVARITE"
        nav2.tabBarItem.image = UIImage(named: "Star-30")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //navi map
        let nav3 = UINavigationController()
        let mapVC = MapVC(nibName: "MapVC", bundle: nil)
        nav3.viewControllers = [mapVC]
        nav3.title = "MAP"
        nav3.tabBarItem.image = UIImage(named: "map30")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //navi setting
        let nav4 = UINavigationController()
        let settingVC = SettingVC(nibName: "SettingVC", bundle: nil)
        nav4.viewControllers = [settingVC]
        nav4.title = "SETTING"
        nav4.tabBarItem.image = UIImage(named: "Settings-30")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        tabbar = UITabBarController()
        tabbar!.viewControllers = [nav1, nav2, nav3, nav4]
        tabbar!.tabBar.barTintColor = uicolorFromHex(16729344)
        tabbar!.tabBar.tintColor = uicolorFromHex(16729344)
        
        self.window?.rootViewController = navigation
        
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func loginSuccess(){
        
        self.window?.rootViewController = tabbar
    }
    func logout(){
        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
        navigation = UINavigationController(rootViewController: loginVC)
        self.window?.rootViewController = navigation
    }
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    func applicationWillResignActive(application: UIApplication) {
     
    }

    func applicationDidEnterBackground(application: UIApplication) {
      
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }


}

