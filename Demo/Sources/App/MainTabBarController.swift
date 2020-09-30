//
//  MainTabBarController.swift
//  DialogDemo
//
//  Created by Dmitry Tikhonov on 21.09.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import Dialog

class MainTabBarController: UITabBarController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let controller = viewControllers?.last {
            Dialog.shared.login(with: "BQ$tV/mKH\"+_ad)VA.OZR@!)", completion: {
                Dialog.shared.embed(.dialogsList, in: controller)

                Dialog.shared.registerForPushNotifications()
            })
        }
    }
}
