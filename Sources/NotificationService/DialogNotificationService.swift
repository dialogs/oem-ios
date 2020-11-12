//
//  DialogNotificationService.swift
//  DialogNotificationService
//
//  Created by Александр Клёмин on 29.09.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import DialogNotificationServiceExtension
import DialogNotifications

final public class DialogNotificationService {

    public static let shared = DialogNotificationService()

    private let notificationServiceEntension = NotificationServiceExtension()

    private init(){}

    public static func configure(with config: DialogSharedAccessConfig) {
        self.shared.notificationServiceEntension.configure(with: config)
    }

    public func canHandle(_ request: UNNotificationRequest) -> Bool {
        // TODO: check userInfo for Dialog key
        return true
    }

    public func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        guard canHandle(request) else {
            contentHandler(request.content)
            return
        }
        notificationServiceEntension.didReceive(request, withContentHandler: contentHandler)
    }

    public func serviceExtensionTimeWillExpire() {
        notificationServiceEntension.serviceExtensionTimeWillExpire()
    }
}

fileprivate class NotificationServiceExtension: DialogNotificationServiceExtension {

    var config: DialogSharedAccessConfig?

    func configure(with config: DialogSharedAccessConfig){
        self.config = config
    }

    override var appGroup: String? {
        return config?.appGroup
    }

    override var keychainGroup: String? {
        return config?.keychainGroup
    }

    override var cryptoManager: DialogCryptoManagable? {
        return SodiumCryptoManager()
    }
}
