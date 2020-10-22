//
//  EntryPointViewController.swift
//  WhiteLabel Share
//
//  Created by Alexander Klemin on 10.01.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import DialogShare
import UIKit

final class EntryPointViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String,
           let appGroup = (Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String).flatMap({ "group." + ($0 as NSString).deletingPathExtension }) {
            DialogShare.configure(keychainGroup: keychainGroup, appGroup: appGroup, appName: "DialogDemo")
            DialogShare.shared.embedViewConroller(in: self)
        }
    }
}
