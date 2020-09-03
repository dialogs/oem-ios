//
//  AppDelegate.swift
//  WhiteLabel
//
//  Created by Alexander Klemin on 07.01.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import Dialog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DialogAppDelegate.shared.window = window
        
        return DialogAppDelegate.shared.application(application, willFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        DialogAppDelegate.shared.applicationDidFinishLaunching(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        DialogAppDelegate.shared.applicationWillTerminate(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        DialogAppDelegate.shared.applicationWillEnterForeground(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        DialogAppDelegate.shared.applicationDidEnterBackground(application)
    }
    
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return DialogAppDelegate.shared.application(application, willContinueUserActivityWithType: userActivityType)
    }
    
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return DialogAppDelegate.shared.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
}

extension AppDelegate {
    
    open func application(_ app: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DialogAppDelegate.shared.application(app, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    open func application(_ app: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        DialogAppDelegate.shared.application(app, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    open func application(_ app: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        DialogAppDelegate.shared.application(app, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return DialogAppDelegate.shared.application(app, open: url, options: options)
    }
    
}
