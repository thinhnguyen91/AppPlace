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
        let navigationHomeVC = UINavigationController()
        let homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
        navigationHomeVC.viewControllers = [homeVC]
        navigationHomeVC.title = "HOME"
        navigationHomeVC.tabBarItem.image = UIImage(named: "Home_2")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //navi favorite
        let navigationFovariteVC = UINavigationController()
        let favoriteVC = FovariteVC(nibName: "FovariteVC", bundle: nil)
        navigationFovariteVC.viewControllers = [favoriteVC]
        navigationFovariteVC.title = "FOVARITE"
        navigationFovariteVC.tabBarItem.image = UIImage(named: "Star-30")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //navi map
        let navigationMapVC = UINavigationController()
        let mapVC = MapVC(nibName: "MapVC", bundle: nil)
        navigationMapVC.viewControllers = [mapVC]
        navigationMapVC.title = "MAP"
        navigationMapVC.tabBarItem.image = UIImage(named: "map30")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //navi setting
        let navigationSeettingVC = UINavigationController()
        let settingVC = SettingVC(nibName: "SettingVC", bundle: nil)
        navigationSeettingVC.viewControllers = [settingVC]
        navigationSeettingVC.title = "SETTING"
        navigationSeettingVC.tabBarItem.image = UIImage(named: "Settings-30")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        tabbar = UITabBarController()
        tabbar!.viewControllers = [navigationHomeVC, navigationFovariteVC, navigationMapVC, navigationSeettingVC]
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

