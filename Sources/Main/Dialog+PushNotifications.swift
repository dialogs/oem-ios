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
}

extension Dialog: DialogAppDelegateProtocol {

    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        childContainer?.resolve(PushNotificationsServiceProtocol.self)?.exchangeKeysIfNeeded()
        childContainer?.resolve(PushNotificationServiceAppDelegateInput.self)?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        childContainer?.resolve(PushNotificationServiceAppDelegateInput.self)?.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
}

public protocol DialogPushNotificationsServiceProtocol {

    func registerForPushNotifications()

    func unregisterForPushNotifications()
}

extension Dialog: DialogPushNotificationsServiceProtocol {

    public func registerForPushNotifications() {
        childContainer?.resolve(PushNotificationsServiceProtocol.self)?.start()
    }

    public func unregisterForPushNotifications() {
        childContainer?.resolve(PushNotificationsServiceProtocol.self)?.stop()
    }
}
