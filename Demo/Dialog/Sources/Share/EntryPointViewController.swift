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
            DialogShare.configure(with: DialogSharedAccessConfig(appGroup: appGroup, keychainGroup: keychainGroup),
                                  style: DialogStyle(corporateColor: #colorLiteral(red: 0.5960784314, green: 0.5333333333, blue: 0.768627451, alpha: 1)),
                                  appName: "DialogDemo")
            DialogShare.shared.embedViewConroller(in: self)
        }
    }
}
