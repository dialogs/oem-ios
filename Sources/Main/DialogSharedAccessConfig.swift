//
//  DialogSharedAccessConfig.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 6.11.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation

public struct DialogSharedAccessConfig {

    public var appGroup: String

    public var keychainGroup: String

    public init(appGroup: String, keychainGroup: String) {
        self.appGroup = appGroup
        self.keychainGroup = keychainGroup
    }
}
