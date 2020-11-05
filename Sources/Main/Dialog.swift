//
//  Dialog.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 16.09.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import DialogAuth
import SwiftGRPC
import DialogNetService
import TrustKit
import Dialog_iOS
import RxSwift
import DialogProtocols

public enum DialogError: Error {
    case failedToResolveServices
    case failedToReceiveToken

    case failedToResolveActiveUser
}

public class Dialog {

    public static let DialogDidLoginNotification = NSNotification.Name("Dialog.DidLoginNotification")
    public static let DialogDidLogoutNotification = NSNotification.Name("Dialog.DidLogoutNotification")

    public struct Config {

        public var endpoint: String

        // TODO: discuss with server right way for apns config
        public var apnsAppId: Int32?

        public var appGroup: String?

        public var keychainGroup: String?

        public var needEnableCallsIntents: Bool

        public var defaultFeatureFlags: [DialogFeatureFlag]

        fileprivate static let empty = Config(endpoint: "")

        public init(endpoint: String,
                    apnsAppId: Int32? = nil,
                    appGroup: String? = nil,
                    keychainGroup: String? = nil,
                    needEnableCallsIntents: Bool = false,
                    defaultFeatureFlags: [DialogFeatureFlag] = []) {
            self.endpoint = endpoint
            self.defaultFeatureFlags = defaultFeatureFlags
            self.apnsAppId = apnsAppId
            self.appGroup = appGroup
            self.needEnableCallsIntents = needEnableCallsIntents
            self.keychainGroup = keychainGroup
        }
    }

    public static let shared = Dialog()

    let container = DialogContainer()

    public internal(set) var badgesState = BadgesState.zero {
        didSet {
            NotificationCenter.default.post(name: Dialog.DialogDidUpdateBadgesStateNotification,
                                            object: nil,
                                            userInfo: [BadgesState.notificationUserInfoKey : badgesState])
        }
    }

    internal let disposeBag = DisposeBag()

    public private(set) var config = Config.empty

    private init() {
    }
    
    public static func configure(with config: Config) {
        Log.debug("Dialog configuration started")
        Self.shared.config = config
        Self.shared.container.register(DialogFeatureFlagsState.self) { _ in
            let oemFeatureFlags = [DialogFeatureFlag(key: .callsEnabled, value: false),
                                   DialogFeatureFlag(key: .videoCallsEnabled, value: false),
                                   DialogFeatureFlag(key: .audioCallsEnabled, value: false),
                                   DialogFeatureFlag(key: .isConferenceEnabled, value: false)]
            return DialogFeatureFlagsState(featureFlags: oemFeatureFlags)
                .applying(newState: DialogFeatureFlagsState(featureFlags: config.defaultFeatureFlags))
        }
        Self.shared.container.register(DialogAppGroupConfig.self) { _ in
            guard let appGroup = config.appGroup else {
                return DialogAppGroupConfig.default
            }
            return DialogAppGroupConfig(appGroupId: appGroup)
        }
        Self.shared.container.register(DialogPushConfig.self) { _ in
            guard let apnsId = config.apnsAppId else {
                return .obsolete(apnsId: 0, voipId: 0)
            }
            return .obsolete(apnsId: apnsId, voipId: 0)
        }
        Self.shared.container.register(DialogBadgesConfig.self) { _ in
            DialogBadgesConfig(needUpdateCallsBadge: false,
                               needUpdateDialogsBadge: false,
                               needUpdateApplicationBadge: false)
        }
        Self.shared.container.register(UserSpecificServiceLauncher.Config.self) { _ in
            return UserSpecificServiceLauncher.Config(needStartPushNotificationsService: false,
                                                      needStartCallsIntentsService: config.needEnableCallsIntents)
        }
        
        
        Self.shared.container.register(OEMAppCoordinator.self) { (container) in
            return OEMAppCoordinator()
        }.inObjectScope(.container)
        
        Self.shared.container.register(AppRouter.self, factory: { resolver in
            return resolver.resolve(OEMAppCoordinator.self)!.strongRouter
        }).inObjectScope(.container)

        Self.shared.container.register(UserEventBusHandler.self) { resolver in
            let currentUser = resolver.resolve(ActiveUsersServiceProtocol.self)!.firstActiveUser
            return UserEventBusHandler(currentUser: currentUser)
        }
        
        Self.shared.startServices()
        if  shared.container.resolve(DialogRootController.self) != nil {
            _ = shared.container.resolve(OEMAppCoordinator.self)
        }
    }

    private func startServices() {
        TrustKit.initSharedInstance(withConfiguration: [:])
        let assembler = DialogAssembler(container: container)
        assembler.registerDefaultDialogServices()
        

        // TODO: Implement other way in platform
        container.resolve(DialogWhatsNewServiceProtocol.self)?.skipWhatsNew()

        let config = container.resolve(DialogAuthConfig.self)
        if config?.isFirstInitOfApp == true {
            try? container.resolve(AuthServiceProtocol.self)?.removeAllAuthEntries()
        }
        
        let currentUser = container.resolve(ActiveUsersServiceProtocol.self)!.firstActiveUser
        let badgeService = BadgeStateService(currentUser: currentUser)
        badgeService.state.do(onNext: { [weak self] state in self?.badgesState = state })
            .subscribe().disposed(by: disposeBag)

        container.resolve(UserEventBusHandler.self)?
            .logout
            .do(onNext: { [weak self] _ in self?.logout(completion: nil) })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func lastAuthedUser() -> AuthUserEntry? {
        return try? (container.resolve(AuthServiceProtocol.self)?.loadAuthEntries())?.first
    }
    
    // MARK: – Login
    
    public func loginWith(token: String, completion: ((Error?) -> Void)?) {
        guard let authService = container.resolve(AuthServiceProtocol.self),
            let registrationInfoProvider = container.resolve(RegistrationTaskPerformerRequestInfoProvider.self),
            let netClient = container.resolve(NetClientProtocol.self) else {
                completion?(DialogError.failedToResolveServices)
                return
        }

        Observable.of(AuthFlowState())
            .applyConfig(.way(.token))
            .applyStep(.configure(.setEndpoints([ServerSettings(address: config.endpoint, isSecure: true)])))
            .applyStep(.configure(.setAuthService(authService)))
            .applyStep(.configure(.setToken(token)))
            .applyConfig(.setRegistrationInfoProvider(registrationInfoProvider))
            .applyConfig(.setNetClient(netClient))
            .applyAction(.requestToken)
            .applyAction(.validateAuthentication)
            .applyAction(.rememberAuthorizedUser)
            .subscribe(onNext: { _ in
                DispatchQueue.main.async {
                    completion?(nil)
                    NotificationCenter.default.post(name: Dialog.DialogDidLoginNotification, object: self)
                    NotificationCenter.default.post(name: ._internalLoginStateMayChange, object: self)
                }
            }, onError: { error in
                DispatchQueue.main.async {
                    completion?(error)
                }
            })
            .disposed(by: disposeBag)
    }

    public func logout(completion: ((Error?) -> Void)?) {
        let authService = container.resolve(AuthServiceProtocol.self)
        guard let activeUser = (try? authService?.loadAuthEntries())??.first else {
            DispatchQueue.main.async {
                completion?(DialogError.failedToResolveActiveUser)
            }
            return
        }

        container.destroyChildContainer(user: activeUser)
        container.logout(user: activeUser)
        container.resolve(AppAuthStateInputServiceProtocol.self)?.stateInput.onNext(.undefined)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Dialog.DialogDidLogoutNotification, object: nil)
            NotificationCenter.default.post(name: ._internalLoginStateMayChange, object: nil)
            self.badgesState = .zero
            completion?(nil)
        }
    }

    public var isLoggedIn: Bool {
        let authService = container.resolve(AuthServiceProtocol.self)
        return ((try? authService?.loadAuthEntries())??.first) != nil
    }
    
}

#if DEVELOP
extension Dialog {
    public func loginWith(username: String, password: String, completion: ((Result<String, Error>) -> Void)?) {
        guard let authService = container.resolve(AuthServiceProtocol.self),
            let registrationInfoProvider = container.resolve(RegistrationTaskPerformerRequestInfoProvider.self),
            let netClient = container.resolve(NetClientProtocol.self) else {
                completion?(.failure(DialogError.failedToResolveServices))
                return
        }

        Observable.of(AuthFlowState())
            .applyConfig(.way(.verification))
            .applyStep(.configure(.setEndpoints([ServerSettings(address: config.endpoint, isSecure: true)])))
            .applyStep(.configure(.setAuthIdentification(.name(username))))
            .applyStep(.configure(.setAuthentication(.password(password))))
            .applyStep(.configure(.setAuthService(authService)))
            .applyConfig(.setRegistrationInfoProvider(registrationInfoProvider))
            .applyConfig(.setNetClient(netClient))
            .applyAction(.requestToken)
            .applyAction(.identify)
            .applyAction(.validateAuthentication)
            // User should not be stored, user must use the login via the token.
            .subscribe(onNext: { flowState in
                DispatchQueue.main.async {
                    if let token = flowState.token {
                        completion?(.success(token))
                    } else {
                        completion?(.failure(DialogError.failedToReceiveToken))
                    }
                }
            }, onError: { error in
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
            })
            .disposed(by: disposeBag)
    }
    
    public func go(to route: DialogGlobalRoute) {
        container.resolve(OEMAppCoordinator.self)?.go(to: route)
    }
}
#endif

internal extension Notification.Name {
    
    static let _internalLoginStateMayChange = Self("im.dlg.internal.loginStateMayChange")
    
}
