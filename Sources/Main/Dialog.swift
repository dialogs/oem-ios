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

        public var defaultFeatureFlags: [DialogFeatureFlag]

        fileprivate static let empty = Config(endpoint: "")

        public init(endpoint: String,
                    apnsAppId: Int32? = nil,
                    appGroup: String? = nil,
                    defaultFeatureFlags: [DialogFeatureFlag] = []) {
            self.endpoint = endpoint
            self.defaultFeatureFlags = defaultFeatureFlags
            self.apnsAppId = apnsAppId
            self.appGroup = appGroup
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

    private let disposeBag = DisposeBag()

    var childContainer: DialogContainer?

    var childContainerDisposeBag: DisposeBag?

    public private(set) var config = Config.empty

    private init() {
    }

    public static func configure(with config: Config) {
        Self.shared.config = config
        Self.shared.container.register(DialogFeatureFlagsState.self) { _ in
            return DialogFeatureFlagsState(featureFlags: config.defaultFeatureFlags)
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
        Self.shared.startServices()
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
        createChildContainer()
    }

    private func createChildContainer() {
        let authService = container.resolve(AuthServiceProtocol.self)
        if let activeUser = (try? authService?.loadAuthEntries())??.first {
            childContainer = container.setupChildContainer(user: activeUser)
            childContainerDisposeBag = DisposeBag()
            container.resolve(AppAuthStateInputServiceProtocol.self)?.stateInput.onNext(.userAuthorized(activeUser))
            NotificationCenter.default.post(name: Dialog.DialogDidLoginNotification, object: nil)
            startBadgesObserving()
        }
    }

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
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.createChildContainer()
                    completion?(nil)
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
        childContainerDisposeBag = nil
        childContainer = nil
        container.resolve(AppAuthStateInputServiceProtocol.self)?.stateInput.onNext(.undefined)
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Dialog.DialogDidLogoutNotification, object: nil)
            self.badgesState = .zero
            completion?(nil)
        }
    }

    public var isLoggedIn: Bool {
        let authService = container.resolve(AuthServiceProtocol.self)
        return ((try? authService?.loadAuthEntries())??.first) != nil
    }

    public enum DialogScreen {
        case dialogsList
    }

    public func embed(_ screen: DialogScreen, in containerView: UIView) -> UIViewController? {
        guard let container = childContainer else {
            return nil
        }

        switch screen {
        case .dialogsList:
            if let viewController = container.resolveSceneViewController(DialogsListScene.self, resolver: container) {
                viewController.view.frame = containerView.bounds
                containerView.addSubview(viewController.view)
                return viewController
            }
        }
        return nil
    }

    public func embed(_ screen: DialogScreen, in containerViewController: UIViewController) -> UIViewController? {
        guard let container = childContainer else {
            return nil
        }

        switch screen {
        case .dialogsList:
            if let viewController = container.resolveSceneViewController(DialogsListScene.self, resolver: container) {
                containerViewController.addChild(viewController)
                viewController.view.frame = containerViewController.view.bounds
                containerViewController.view.addSubview(viewController.view)
                viewController.didMove(toParent: containerViewController)
                return viewController
            }
        }
        return nil
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
            .applyAction(.rememberAuthorizedUser)
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
}
#endif
