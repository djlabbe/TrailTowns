//
//  AppDelegate.swift
//  TrailTowns
//
//  Created by Douglas Labbe on 11/16/15.
//  Copyright © 2015 Douglas Labbe. All rights reserved.
//

import Parse
import Bolts
import UIKit
import CoreData

let white = UIColor.whiteColor()
let black = UIColor.blackColor()

let lightGray = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
let darkGray = UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0)

let darkGreen = UIColor(red: 25.0 / 255.0, green: 75.0/255.0, blue: 5.0/255.0, alpha: 1.0)
let midGreen = UIColor(red: 65.0 / 255.0, green: 115.0/255.0, blue: 20.0/255.0, alpha: 1.0)
let lightGreen = UIColor(red: 105.0 / 255.0, green: 155.0/255.0, blue: 35.0/255.0, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = white
        UIBarButtonItem.appearance().tintColor = white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : white]
        
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("aTs2bmaShtAXpq9MaSwmRz58zgjIZg9oNstWICMd",
            clientKey: "9pMDzQuPlyMoX1EaDLwsiPHQeI4YjDzvzdaNm51E")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

