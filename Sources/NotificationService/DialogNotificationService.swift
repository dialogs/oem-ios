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

    public static func configure(keychainGroup: String?, appGroup: String?) {
        self.shared.notificationServiceEntension.configure(keychainGroup: keychainGroup, appGroup: appGroup)
    }

    public func canHandle(_ request: UNNotificationRequest) -> Bool {
        // TODO: check userInfo for Dialog key
        return true
    }

    public func handle(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        guard canHandle(request) else {
            contentHandler(request.content)
            return
        }
        notificationServiceEntension.didReceive(request, withContentHandler: contentHandler)
    }

}

fileprivate class NotificationServiceExtension: DialogNotificationServiceExtension {

    var extensionKeychainGroup: String? = nil

    var extensionAppGroup: String? = nil

    func configure(keychainGroup: String?, appGroup: String?){
        self.extensionKeychainGroup = keychainGroup
        self.extensionAppGroup = appGroup
    }

    override var appGroup: String? {
        return extensionAppGroup
    }

    override var keychainGroup: String? {
        return extensionKeychainGroup
    }

    override var cryptoManager: DialogCryptoManagable? {
        return SodiumCryptoManager()
    }
}
