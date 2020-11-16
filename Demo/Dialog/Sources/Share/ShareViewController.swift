//
//  ShareViewController.swift
//  DialogDemo Share
//
//  Created by Александр Клёмин on 07.09.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import DialogShare

final class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let appGroup = Bundle.main.object(forInfoDictionaryKey: "App group") as? String, let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String {
            DialogShare.configure(
                with: DialogSharedAccessConfig(appGroup: appGroup, keychainGroup: keychainGroup),
                style: DialogStyle(corporateColor: #colorLiteral(red: 0.5960784314, green: 0.5333333333, blue: 0.768627451, alpha: 1)),
                appName: Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
            )
            DialogShare.shared.embedViewConroller(in: self)
        }
    }
    
}
