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

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let appGroup = Bundle.main.bundleIdentifier.flatMap({ "group." + $0 })
        let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String

        Dialog.configure(with: Dialog.Config(endpoint: "grpc-oem-01.apps.sandbox.dlg.im",
                                             apnsAppId: 100101,
                                             appGroup: appGroup,
                                             keychainGroup: keychainGroup))
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Dialog.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Dialog.shared.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Dialog.shared.canHandlePushNotificationWith(userInfo: userInfo) {
            Dialog.shared.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
    }
}
