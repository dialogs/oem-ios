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

        if Dialog.shared.isLoggedIn {
            dialogDidLogin()
        }
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
}
