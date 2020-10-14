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

    internal func startBadgesObserving() {
        guard let service = childContainer?.resolve(UnreadCounterServiceProtocol.self),
              let disposeBag = childContainerDisposeBag else {
            return
        }

        service
            .counter
            .map({ BadgesState(unreadMessages: $0.values.reduce(0, { $0 + Int($1.dialogUnread.count) }),
                               unreadDialogs: $0.values.count) })
            .startWith(.zero)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] state in
                self?.badgesState = state
            })
            .disposed(by: disposeBag)
    }
}
