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

        public var sharedAccessConfig: DialogSharedAccessConfig?

        public var needEnableCallsIntents: Bool

        public var defaultFeatureFlags: [DialogFeatureFlag]

        fileprivate static let empty = Config(endpoint: "")

        public init(endpoint: String,
                    apnsAppId: Int32? = nil,
                    sharedAccessConfig: DialogSharedAccessConfig? = nil,
                    needEnableCallsIntents: Bool = false,
                    defaultFeatureFlags: [DialogFeatureFlag] = []) {
            self.endpoint = endpoint
            self.defaultFeatureFlags = defaultFeatureFlags
            self.apnsAppId = apnsAppId
            self.sharedAccessConfig = sharedAccessConfig
            self.needEnableCallsIntents = needEnableCallsIntents
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
    
    public static func configure(with config: Config, style: DialogStyle) {
        Log.debug("Dialog configuration started")
        
        Self.shared.registerTheme(with: style)
        
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
            guard let appGroup = config.sharedAccessConfig?.appGroup else {
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
        
        var config = DialogsListScene.DefaultBuilderConfig.default
        config.showContacts = true
        Self.shared.container.register(DialogsListScene.DefaultBuilderConfig.self, factory: { _ in config })
        
        Self.shared.startServices()
        
        if shared.container.resolve(DialogRootController.self) != nil {
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
                    NotificationCenter.default.post(name: ._internalLoginStateMayChange, object: self)
                    completion?(nil)
                    NotificationCenter.default.post(name: Dialog.DialogDidLoginNotification, object: self)
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

    private func registerTheme(with style: DialogStyle) {
        container.register(AppThemeService.self) { _ in
            var theme = BasicAppTheme.appTheme

            theme.modify(subthemeForKeys: Theme.Keys.General.self) { theme in
                theme.set(colors: [
                    .controlActiveColor: style.corporateColor
                ])
            }

            theme.modify(subthemeForKeys: Theme.Keys.MessageBubbles.self) { theme in
                theme.set(colors: [
                    .messageBackgroundColor: UIColor.color { mode -> UIColor in
                        return mode == .dark ? UIColor(white: 0.2, alpha: 1.0) : #colorLiteral(red: 0.9499492049, green: 0.9499714971, blue: 0.9499594569, alpha: 1)
                    },
                    .myMessageBackgroundColor: style.corporateColor,
                    .replyIndentLineColor: style.corporateColor
                ])

                if let bubbleColors = style.bubbleColors {
                    for (key, value) in bubbleColors {
                        theme.set(key: key.themeKey, value: .color(value))
                    }
                }
            }

            theme.modify(subthemeForKeys: Theme.Keys.ConversationView.self) { theme in
                if let color = style.dialogBackgroundColor {
                    theme.set(key: .conversationBackgroundColor, value: .color(color))
                }
                if let color = style.pinnedDialogBackgroundColor {
                    theme.set(key: .pinnedConversationBackgroundColor, value: .color(color))
                }
                if let image = style.dialogBackgroundImage {
                    theme.set(key: .conversationBackgroundImage, value: .image(.init(image: image)))
                }
            }

            let provider = AppThemeProvider(id: "DialogTheme", theme: theme)
            let themeService = AppThemeProvider.service(initial: provider)
            
            // We've got a strange crash here, probably because of RxTheme's thread unsafe cache underhood usage.
            _ = themeService.attrs

            return themeService
        }

        if let avatarColors = style.avatarColors {
            container.register(DialogPeerColorsService.Config.self) { _ in
                return DialogPeerColorsService.Config(avatarColors: avatarColors)
            }
        }
        
        if let themeService = container.resolve(AppThemeService.self), let rootViewController = container.resolve(DialogRootController.self) {
            themeService
                .generalControlColor()
                .bind(to: rootViewController.navigationBar.rx.tintColor)
                .disposed(by: disposeBag)
        }
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
