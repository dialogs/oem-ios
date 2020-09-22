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

public class Dialog {

    public struct Config {

        public var endpoint: String

        public var defaultFeatureFlags: [DialogFeatureFlag]

        fileprivate static let empty = Config(endpoint: "")

        public init(endpoint: String, defaultFeatureFlags: [DialogFeatureFlag] = []) {
            self.endpoint = endpoint
            self.defaultFeatureFlags = defaultFeatureFlags
        }
    }

    public static let shared = Dialog()

    private let container = DialogContainer()

    private var childContainer: DialogContainer?

    private let disposeBag = DisposeBag()

    private var config = Config.empty

    private init() {
        TrustKit.initSharedInstance(withConfiguration: [:])
        let assembler = DialogAssembler(container: container)
        assembler.registerDefaultDialogServices()
        createChildContainer()

        // TODO: Implement other way in platform
        container.resolve(DialogWhatsNewServiceProtocol.self)?.skipWhatsNew()
    }

    public static func configure(with config: Config) {
        Self.shared.config = config
        Self.shared.container.register(DialogFeatureFlagsState.self) { _ in
            return DialogFeatureFlagsState(featureFlags: config.defaultFeatureFlags)
        }
    }

    private func createChildContainer() {
        let authService = container.resolve(AuthServiceProtocol.self)
        if let activeUser = (try? authService?.loadAuthEntries())??.first {
            childContainer = container.setupChildContainer(user: activeUser)
        }
    }

    public func login(with token: String, completion: (() -> Void)?) {
        let endpoint = config.endpoint

        let authService = container.resolve(AuthServiceProtocol.self)
        let channel = Channel(address: endpoint, secure: true)
        let netService = DialogNetService.NetClient()
        let performer = AuthenticationTaskPerformer(channel: channel, token: token, netService: netService)

        performer
            .performUsingAppliedToken()
            .flatMap({ info -> Observable<Void> in
                let channelSecurity = ChannelSecurity.secure(rootCertificates: .default, clientCredentials: nil)
                let channelInfo = ChannelBasedServiceRestorableInfo(endpoint: endpoint, token: token, security: channelSecurity)

                let restorableInfo = RestorableAuthEntry(userId: info.user.id,
                                                         authDate: Date(),
                                                         channelInfo: channelInfo)
                return authService?.store(restorableEntry: restorableInfo, user: info.user, config: info.config, clientCredentialsIdentity: nil).asObservable() ?? .never()
            })
            .subscribe(onCompleted: { [weak self] in
                DispatchQueue.main.async {
                    self?.createChildContainer()
                    completion?()
                }
            })
            .disposed(by: disposeBag)
    }

    public enum DialogScreen {
        case dialogsList
    }

    public func embed(_ screen: DialogScreen, in containerView: UIView) {
        guard let container = childContainer else {
            return
        }

        switch screen {
        case .dialogsList:
            if let viewController = container.resolveSceneViewController(DialogsListScene.self, resolver: container) {
                viewController.view.frame = containerView.bounds
                containerView.addSubview(viewController.view)
            }
        }
    }

    public func embed(_ screen: DialogScreen, in containerViewController: UIViewController) {
        guard let container = childContainer else {
            return
        }

        switch screen {
        case .dialogsList:
            if let viewController = container.resolveSceneViewController(DialogsListScene.self, resolver: container) {
                containerViewController.addChild(viewController)
                viewController.view.frame = containerViewController.view.bounds
                containerViewController.view.addSubview(viewController.view)
                viewController.didMove(toParent: containerViewController)
            }
        }
    }

}
