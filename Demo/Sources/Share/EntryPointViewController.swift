//
//  EntryPointViewController.swift
//  WhiteLabel Share
//
//  Created by Alexander Klemin on 10.01.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import DialogShareExtension

final class EntryPointViewController: DialogShareExtensionController {
    
    private let configurator = CommonConfigurator()
    
    override var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    }

    override var primaryTintColor: UIColor {
        return configurator.corporateColor
    }
    
    override var keychainGroup: String? {
        return Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String
    }
    
    override var useSslPinning: Bool {
        return configurator.useSslPinning
    }

    override var avatarColors: [UIColor] {
        return configurator.avatarColors
    }
    
    override func configureTrustKit() {
        configurator.configureTrustKit()
    }
    
}
