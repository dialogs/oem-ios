//
//  DialogViewController.swift
//  DialogDemo
//
//  Created by Dmitry Tikhonov on 05.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import Dialog

class DialogViewController: UIViewController {

    private var dialogViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(dialogDidLogin), name: Dialog.DialogDidLoginNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dialogDidLogout), name: Dialog.DialogDidLogoutNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dialogDidUpdateBadgesState(_:)), name: Dialog.DialogDidUpdateBadgesStateNotification, object: nil)

        if Dialog.shared.isLoggedIn {
            dialogDidLogin()
        }

        updateBadges(Dialog.shared.badgesState)
    }

    @objc
    private func dialogDidLogin() {
        if dialogViewController == nil {
            dialogViewController = Dialog.shared.embed(.dialogsList, in: self)
            Dialog.shared.registerForPushNotifications()
        }
    }

    @objc
    private func dialogDidLogout() {
        dialogViewController?.removeFromParent()
        dialogViewController?.view.removeFromSuperview()
        dialogViewController?.didMove(toParent: nil)
        dialogViewController = nil
    }

    @objc
    private func dialogDidUpdateBadgesState(_ notification: Notification) {
        if let state = notification.userInfo?[Dialog.BadgesState.notificationUserInfoKey] as? Dialog.BadgesState {
            self.updateBadges(state)
        }
    }

    private func updateBadges(_ badgesState: Dialog.BadgesState) {
        self.tabBarItem.badgeValue = badgesState.unreadDialogs > 0 ? String(badgesState.unreadDialogs) : nil
        UIApplication.shared.applicationIconBadgeNumber = badgesState.unreadDialogs
    }
}
