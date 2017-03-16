//
//  AppDelegate.swift
//  #360
//
//  Created by Tommy Lam on 23/12/2016.
//  Copyright © 2016 tik. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    
    let beaconNotificationsManager = BeaconNotificationsManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // You can get them by adding your app on https://cloud.estimote.com/#/apps
        ESTConfig.setupAppID("lamchinghong-gmail-com-s-y-ivu", andAppToken: "76274cebb3cc229be51511d754ec5f88")
        
        self.beaconNotificationsManager.enableNotifications(
            
            for: BeaconID(UUIDString: "7B44B47B-52A1-5381-90C2-F09B6838C5D4", major: 0, minor: 0),
            enterMessage: "Your Beacon is detected.",
            exitMessage: "You're leaving your Beacon"
        )
        
        // NOTE: "exit" event has a built-in delay of 30 seconds, to make sure that the user has really exited the beacon's range. The delay is imposed by iOS and is non-adjustable.

        
        // Override point for customization after application launch.
        FIRApp.configure()
        logUser()
        return true
    }
    
    func logUser(){
        
        if FIRAuth.auth()!.currentUser != nil {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tab") as! UITabBarController
            window?.rootViewController = vc
        }else{
            
            FIRAuth.auth()?.signInAnonymously() { (user, error) in
                let isAnonymous = user!.isAnonymous  // true
                let uid = user!.uid
                let viewController =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tab") as! UITabBarController
            
            // Creating a navigation controller with viewController at the root of the navigation stack.
            
            self.window?.rootViewController = viewController
            

            }
            
                        
            
        }
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


