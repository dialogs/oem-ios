//
//  NotificationService.swift
//  WhiteLabel Notification Service
//
//  Created by Alexander Klemin on 08.01.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import DialogNotifications
import DialogNotificationService

class NotificationService: DialogNotificationService {

    override var keychainGroup: String? {
        return Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String
    }

    override var cryptoManager: DialogCryptoManagable? {
        return SodiumCryptoManager()
    }

}
