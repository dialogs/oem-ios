//
//  Dialog+PushNotifications.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 09.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import Dialog_iOS
import DialogProtocols

public protocol DialogAppDelegateProtocol {

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
}

extension Dialog: DialogAppDelegateProtocol {

    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        childContainer?.resolve(PushNotificationsServiceProtocol.self)?.exchangeKeysIfNeeded()
        childContainer?.resolve(PushNotificationServiceAppDelegateInput.self)?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        childContainer?.resolve(PushNotificationServiceAppDelegateInput.self)?.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let info = NotificationInfo.anonymous(.init(payload: userInfo, completionHandler: completionHandler))
        container
            .resolve(GlobalNotificationUserProxyServiceProtocol.self)?
            .handleNotification(info)
    }
}

public protocol DialogPushNotificationsServiceProtocol {

    func registerForPushNotifications()

    func unregisterForPushNotifications()

    func canHandlePushNotificationWith(userInfo: [AnyHashable: Any]) -> Bool
}

extension Dialog: DialogPushNotificationsServiceProtocol {

    public func registerForPushNotifications() {
        childContainer?.resolve(PushNotificationsServiceProtocol.self)?.start()
    }

    public func unregisterForPushNotifications() {
        childContainer?.resolve(PushNotificationsServiceProtocol.self)?.stop()
    }

    public func canHandlePushNotificationWith(userInfo: [AnyHashable: Any]) -> Bool {
        // TODO: check userInfo for Dialog key
        return true
    }
}
