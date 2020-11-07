//
//  LogoutService.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 30.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import RxSwift
import DialogProtocols
import Dialog_iOS

internal final class LogoutService {

    public let logout: Observable<Void>

    public init(currentUser: Observable<AuthUserEntry?>) {
        logout = currentUser
            .flatMapLatest({ user -> Observable<Void> in
                guard let entry = user else {
                    return .never()
                }

                let containers = Dialog.shared.container.resolve(SwinjectUserContainersServiceProtocol.self)!
                let resolver = containers.getResolver(user: entry)!
                let userEventBus = resolver.resolve(UserEventBusServiceProtocol.self)!
                return userEventBus
                    .eventOutput
                    .filter({
                        if case .logout = $0 {
                            return true
                        }
                        return false
                    })
                    .mapTo(())
                    .observeOn(MainScheduler.asyncInstance)
            })
    }
}
