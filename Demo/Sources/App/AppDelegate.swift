//
//  AppDelegate.swift
//  WhiteLabel
//
//  Created by Alexander Klemin on 07.01.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import Dialog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        Dialog.configure(with: Dialog.Config(endpoint: "grpc-plat-01.apps.sandbox.dlg.im:443"))

        return true
    }
}
