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
    
    var badgeUpdateHolder: Any? = nil
    var routeLoggingHolder: Any? = nil

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let appGroup = Bundle.main.bundleIdentifier.flatMap({ "group." + $0 })
        let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String

        Dialog.configure(with: Dialog.Config(endpoint: "grpc-oem-01.apps.sandbox.dlg.im",
                                             apnsAppId: 100101,
                                             appGroup: appGroup,
                                             keychainGroup: keychainGroup))
        
        badgeUpdateHolder = NotificationCenter.default
            .addObserver(forName: Dialog.DialogDidUpdateBadgesStateNotification,
                         object: nil,
                         queue: .main,
                         using: { notification in
                            let userInfoKey = Dialog.BadgesState.notificationUserInfoKey
                            var result = 0
                            if let state = notification.userInfo?[userInfoKey] as? Dialog.BadgesState {
                                result = state.unreadDialogs
                            }
                            UIApplication.shared.applicationIconBadgeNumber = result
                         })
        
        
        routeLoggingHolder = NotificationCenter.default
            .addObserver(forName: .DialogCoordinationNotification, object: nil, queue: nil, using: { (notification) in
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

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Dialog.shared.canHandlePushNotificationWith(userInfo: userInfo) {
            Dialog.shared.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
    }
}
