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
        guard let appGroup = Bundle.main.object(forInfoDictionaryKey: "App group") as? String, let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String else {
            contentHandler(request.content)
            return
        }

        if DialogNotificationService.shared.canHandle(request) {
            DialogNotificationService.configure(with: DialogSharedAccessConfig(appGroup: appGroup, keychainGroup: keychainGroup))
            DialogNotificationService.shared.didReceive(request, withContentHandler: contentHandler)
        } else {
            contentHandler(request.content)
        }
    }

    override func serviceExtensionTimeWillExpire() {
        DialogNotificationService.shared.serviceExtensionTimeWillExpire()
    }
}
