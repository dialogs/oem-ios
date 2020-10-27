//
//  OEMAppCoordinator.swift
//  Dialog
//
//  Created by Gordeev Aleksey on 23.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import UIKit
import Dialog_iOS
import XCoordinator
import DialogProtocols
import Swinject
import RxSwift

public final class OEMAppCoordinator: NavigationCoordinator<AppRoute> {
    
    private var authedUserCoordinator: OEMAuthedUserCoordinator? = nil
    
    private let container: Swinject.Container
    
    private let bag = DisposeBag()
    
    private let appState = BehaviorSubject(value: AppAuthState.undefined)
    
    init(container: Swinject.Container = Dialog.shared.container) {
        self.container = container
        
        let viewController = container.resolve(DialogRootController.self)
            ?? DialogRootController(navigationBarClass: nil, toolbarClass: nil)
        
        super.init(rootViewController: viewController, initialRoute: nil)
        
        container.register(AppRouterServiceProtocol.self) { (resolver) in
            Log.debug("True lazy router resolved!")
            return LazyAppRouterService(resolving: {
                return self.strongRouter
            })
        }.inObjectScope(.container)
        
        container
            .resolve(ActiveUsersServiceProtocol.self)!
            .activeUsers
            .map({ $0.first })
            .distinctUntilChanged()
            .map { [weak self] (entry) -> AppRoute in
                if let entry = entry {
                    self?.setupUserCoordinator(for: entry)
                    
                    let route = GlobalAppRoute.AuthedUser(entry: entry, route: .dialogsRoute(DialogsRoute.dialogs))
                    return .global(.user(route))
                } else {
                    self?.authedUserCoordinator = nil
                    return .authType
                }
            }.do(onNext: { [weak self] (route) in
                Log.debug("Triggering route \(route)")
                self?.trigger(route)
            }).subscribe().disposed(by: bag)
        
        observeUserLoginState()
    }
    
    private func observeUserLoginState() {
        let center = NotificationCenter.default.rx
        let didLogin = center.notification(Dialog.DialogDidLoginNotification).mapTo(Void())
        let didLogout = center.notification(Dialog.DialogDidLogoutNotification).mapTo(Void())
        let resetCurrentUserTrigger = Observable.merge([didLogin, didLogout]).startWith(Void())
        let lastAuthedUser = resetCurrentUserTrigger.map({ [weak self] in
            return self?.loadUser()
        }).distinctUntilChanged()
        
        lastAuthedUser.do(onNext: { [weak self] user in
            if let user = user {
                self?.appState.onNext(.goingToAuthorize(DialogUserId(user.userId)!))
                Log.debug("Newly logged in user discovered. Activating \(user)")
                _ = self?.container.setupChildContainer(user: user)
            } else {
                Log.debug("No logged in user discovered.")
            }
        }).subscribe().disposed(by: bag)
    }
    
    private func prepareTransition(for globalRoute: GlobalAppRoute) -> NavigationTransition {
        switch globalRoute {
        case .user(let authedUserRoute):
            guard let coordinator = authedUserCoordinator, coordinator.user == authedUserRoute.entry else {
                Log.error("Unexpected route \(authedUserRoute)")
                return .none()
            }
            coordinator.trigger(authedUserRoute.route)
            return .none()
        }
    }
    
    private func loadUser() -> AuthUserEntry? {
        let users = (try? container.resolve(AuthServiceProtocol.self)?.loadAuthEntries()) ?? []
        return users.first
    }
    
    private func setupUserCoordinator(for user: AuthUserEntry) {
        self.authedUserCoordinator = create(userCoordinatorFor: user)
        Log.debug("User coordinator setup")
    }
    
    private func create(userCoordinatorFor user: AuthUserEntry) -> OEMAuthedUserCoordinator {
        let userContainer = container.setupChildContainer(user: user)
        let coordinator = OEMAuthedUserCoordinator(user: user,
                                                   rootViewController: self.rootViewController,
                                                   container: userContainer)
        self.addChild(coordinator)
        return coordinator
    }
    
    private func placeholderControllerForNoAuthorizedUser() -> UIViewController {
        let vc = UIViewController()
        let label = UILabel()
        label.text = "No User"
        label.textAlignment = .center
        vc.view.addSubview(label)
        label.frame = vc.view.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return vc
    }
    
    public override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .authType:
            let vc = placeholderControllerForNoAuthorizedUser()
            return .set([vc])
        case .global(let globalRoute):
            return self.prepareTransition(for: globalRoute)
        default:
            return .none()
        }
    }
    
    private func prepareTransition(for authedUserRoute: GlobalAppRoute.AuthedUser) -> ViewTransition {
        return .none()
    }
    
//    public override func prepareTransition(for route: AppRoute) -> ViewTransition {
//        switch route {
//        case .global(let globalRoute):
//            return prepareTransition(for: globalRoute)
//        default:
//            Log.error("Triggered for route not available for OEM yet: \(route)")
//            return .none()
//        }
//    }
    
}
