//
//  BadgeStateService.swift
//  Dialog
//
//  Created by Gordeev Aleksey on 27.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import RxSwift
import DialogProtocols
import Dialog_iOS

public final class BadgeStateService {
    
    public var state: Observable<Dialog.BadgesState>
    
    public init(currentUser: Observable<AuthUserEntry?>) {
        state = currentUser
            .flatMapLatest({ (user) -> Observable<Dialog.BadgesState> in
                guard let entry = user else {
                    return .just(.zero)
                }
                let containers = Dialog.shared.container.resolve(SwinjectUserContainersServiceProtocol.self)!
                let resolver = containers.getResolver(user: entry)!
                let baseService = resolver.resolve(UnreadCounterServiceProtocol.self)!
                return baseService
                    .counter
                    .map({ Dialog.BadgesState(unreadMessages: $0.values.reduce(0, { $0 + Int($1.dialogUnread.count) }),
                                              unreadDialogs: $0.values.count) })
            })
            .observeOn(MainScheduler.asyncInstance)
    }    
}
