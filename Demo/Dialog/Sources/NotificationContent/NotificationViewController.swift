//
//  NotificationViewController.swift
//  DialogDemo Notification Content
//
//  Created by Александр Клёмин on 07.09.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UserNotificationsUI
import DialogNotificationContent

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let appGroup = Bundle.main.object(forInfoDictionaryKey: "App group") as? String, let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String {
            DialogNotificationContent.configure(
                with: DialogSharedAccessConfig(appGroup: appGroup, keychainGroup: keychainGroup),
                style: DialogStyle(corporateColor: #colorLiteral(red: 0.5960784314, green: 0.5333333333, blue: 0.768627451, alpha: 1))
            )
            DialogNotificationContent.shared.embedViewConroller(in: self)
        }
    }

    func didReceive(_ notification: UNNotification) {
        DialogNotificationContent.shared.didReceive(notification)
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        DialogNotificationContent.shared.didReceive(response, completionHandler: completion)
    }
    
}
