//
//  UserEventBusHandler.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 03.11.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import RxSwift
import DialogProtocols
import Dialog_iOS

internal final class UserEventBusHandler {

    public let logout: Observable<Void>

    public let openDialog: Observable<DialogPeer>

    public let openProfile: Observable<DialogUser>

    public init(currentUser: Observable<AuthUserEntry?>) {
        let events = currentUser
            .flatMapLatest({ user -> Observable<UserEvent> in
                guard let entry = user else {
                    return .never()
                }

                let containers = Dialog.shared.container.resolve(SwinjectUserContainersServiceProtocol.self)!
                let resolver = containers.getResolver(user: entry)!
                let userEventBus = resolver.resolve(UserEventBusServiceProtocol.self)!
                return userEventBus.eventOutput
            })
            .share(replay: 1, scope: .whileConnected)

        logout = events
            .filter({
                if case .logout = $0 {
                    return true
                }
                return false
            })
            .mapTo(())
            .observeOn(MainScheduler.asyncInstance)

        openProfile = events
            .map({
                switch $0 {
                case .openUserProfile(let user):
                    return user
                default:
                    return nil
                }
            })
            .unwrap()
            .observeOn(MainScheduler.asyncInstance)

        openDialog = events
            .map({
                switch $0 {
                case .openDialog(let state, _, _):
                    return state.peer
                case .open(let peer, _):
                    return peer
                default:
                    return nil
                }
            })
            .unwrap()
            .observeOn(MainScheduler.asyncInstance)
    }
}

