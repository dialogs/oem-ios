//
//  Dialog+Badges.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 12.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import Dialog_iOS
import RxSwift

public extension Dialog {

    static let DialogDidUpdateBadgesStateNotification = NSNotification.Name("Dialog.DidUpdateBadgesStateNotification")

    struct BadgesState {
        public let unreadMessages: Int
        public let unreadDialogs: Int

        static let zero = BadgesState(unreadMessages: 0, unreadDialogs: 0)

        public static let notificationUserInfoKey = "state"
    }
}
