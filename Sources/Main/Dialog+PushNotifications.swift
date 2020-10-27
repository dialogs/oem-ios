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
import Swinject

public protocol DialogAppDelegateProtocol {

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
}

extension Dialog: DialogAppDelegateProtocol {

    private func withCurrentUserResolver(_ handler: @escaping ((AuthUserEntry, Swinject.Resolver) -> Void)) {
        guard let auth = container.resolve(AppAuthStateServiceProtocol.self) else {
            return
        }
        auth.doWithAuthedUserIgnoringOtherCases().do(onNext: { [container] entry in
            guard let resolver = container.resolve(SwinjectUserContainersServiceProtocol.self)?
                    .getResolver(user: entry) else {
                return
            }
            handler(entry, resolver)
        }).subscribe().disposed(by: disposeBag)
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        withCurrentUserResolver { (_, resolver) in
            resolver.resolve(PushNotificationsServiceProtocol.self)?.exchangeKeysIfNeeded()
            resolver.resolve(PushNotificationServiceAppDelegateInput.self)?.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }

    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        withCurrentUserResolver { (_, resolver) in
            resolver.resolve(PushNotificationServiceAppDelegateInput.self)?.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
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
        withCurrentUserResolver { (_, resolver) in
            resolver.resolve(PushNotificationsServiceProtocol.self)?.start()
        }
    }

    public func unregisterForPushNotifications() {
        withCurrentUserResolver { (_, resolver) in
            resolver.resolve(PushNotificationsServiceProtocol.self)?.stop()
        }
    }

    public func canHandlePushNotificationWith(userInfo: [AnyHashable: Any]) -> Bool {
        // TODO: check userInfo for Dialog key
        return true
    }
}
