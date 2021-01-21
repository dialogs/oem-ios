//
//  AppDelegate.swift
//  DialogDemo
//
//  Created by Александр Клёмин on 07.09.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import Dialog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var badgeUpdateHolder: Any?
    var routeLoggingHolder: Any?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        var sharedAccessConfig: DialogSharedAccessConfig?
        
        if let appGroup = Bundle.main.object(forInfoDictionaryKey: "App group") as? String, let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String {
            sharedAccessConfig = DialogSharedAccessConfig(appGroup: appGroup, keychainGroup: keychainGroup)
        }

        Dialog.configure(
            with: Dialog.Config(endpoint: "eem.dlg.im", apnsAppId: 100101, sharedAccessConfig: sharedAccessConfig),
            style: DialogStyle(corporateColor: #colorLiteral(red: 0.5960784314, green: 0.5333333333, blue: 0.768627451, alpha: 1))
        )
        
        badgeUpdateHolder = NotificationCenter.default
            .addObserver(forName: Dialog.DialogDidUpdateBadgesStateNotification, object: nil, queue: .main, using: { notification in
                let userInfoKey = Dialog.BadgesState.notificationUserInfoKey
                var result = 0
                        
                if let state = notification.userInfo?[userInfoKey] as? Dialog.BadgesState {
                    result = state.unreadDialogs
                }
                        
                UIApplication.shared.applicationIconBadgeNumber = result
            })
        
        routeLoggingHolder = NotificationCenter.default
            .addObserver(forName: .DialogCoordinationNotification, object: nil, queue: nil, using: { notification in
                let key = Notification.DialogCoordinationUserInfoRouteKey
                
                if let route = notification.userInfo?[key] as? DialogGlobalRoute {
                    print("Dialog routed to \(route)")
                } else {
                    print("Dialog posted a route notification with invalid user info \(notification.userInfo ?? [:])")
                }
            })
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Dialog.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Dialog.shared.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Dialog.shared.canHandlePushNotificationWith(userInfo: userInfo) {
            Dialog.shared.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
    }
    
}
