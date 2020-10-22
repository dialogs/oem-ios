//
//  NotificationViewController.swift
//  WhiteLabel Notification Content
//
//  Created by Александр Клёмин on 01.04.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UserNotificationsUI
import DialogNotificationContent

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String,
           let appGroup = (Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String).flatMap({ "group." + ($0 as NSString).deletingPathExtension }) {
            DialogNotificationContent.configure(keychainGroup: keychainGroup, appGroup: appGroup)
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
