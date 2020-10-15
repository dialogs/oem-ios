//
//  NotificationService.swift
//  WhiteLabel Notification Service
//
//  Created by Alexander Klemin on 08.01.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UserNotifications
import DialogNotificationService

class NotificationService: UNNotificationServiceExtension {

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {

        DialogNotificationService.configure(keychainGroup: Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String,
                                            appGroup: (Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String).flatMap({ "group." + ($0 as NSString).deletingPathExtension }))

        if DialogNotificationService.shared.canHandle(request) {
            DialogNotificationService.shared.handle(request, withContentHandler: contentHandler)
        }
    }
}
