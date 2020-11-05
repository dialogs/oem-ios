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

internal final class OEMAppCoordinator: NavigationCoordinator<AppRoute> {
    
    private struct Constants {
        var routeInfoGatheringTimeout: RxTimeInterval = .seconds(1)
    }
    
    private static let constants = Constants()
    
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
        
        startReportingAppAuthState()
        observeUserLoginState()
        setupAlertNotificationObserving()
        observeUserEventBusEvents()
    }
    
    public func go(to route: DialogGlobalRoute) {
        
        guard let user = authedUserCoordinator?.user else {
            Log.debug("Requested route for a user but no user authorized")
            return
        }
        
        switch route {
        case .dialogs:
            self.trigger(.global(.user(GlobalAppRoute.AuthedUser.init(entry: user,
                                                                      route: .dialogsRoute(.dialogs)))))
            
        case .dialogUser(let id):
            let peer = DialogPeer.zero.modified(closure: { $0.id = id; $0.type = .private })
            loadDataForRouteToDialog(peer: peer).do(onNext: { [weak self] dialog, unreadCount in
                let subroute = DialogsRoute.dialog(dialog, unreadCountState: unreadCount, messageId: nil)
                self?.trigger(.global(.user(.init(entry: user, route: .dialogsRoute(subroute)))))
            }).subscribe().disposed(by: bag)
            
        case .dialogGroup(let id):
            let peer = DialogPeer.zero.modified(closure: { $0.id = id; $0.type = .group })
            loadDataForRouteToDialog(peer: peer).do(onNext: { [weak self] dialog, unreadCount in
                let subroute = DialogsRoute.dialog(dialog, unreadCountState: unreadCount, messageId: nil)
                self?.trigger(.global(.user(.init(entry: user, route: .dialogsRoute(subroute)))))
            }).subscribe().disposed(by: bag)
            
        case .profile(let peer):
            let route: DialogsRoute
            switch peer.type {
            case .group:
                route = DialogsRoute.groupProfile(.init(id: peer.id))
            case .private, .encryptedprivate:
                route = DialogsRoute.userProfile(.init(id: peer.id))
            default:
                return
            }
            self.trigger(.global(.user(.init(entry: user, route: .dialogsRoute(route)))))
            
        case .createDialog:
            self.trigger(.global(.user(.init(entry: user, route: .dialogsRoute(.createDialog)))))
            
        case .searchDialog:
            self.trigger(.global(.user(.init(entry: user, route: .dialogsRoute(.beginSearch)))))
            
        }
    }
    
    private func startReportingAppAuthState() {
        if let service = container.resolve(AppAuthStateInputServiceProtocol.self) {
            self.appState.subscribe(service.stateInput).disposed(by: bag)
        }
    }
    
    private func observeUserLoginState() {
        let resetCurrentUserTrigger = NotificationCenter.default.rx
            .notification(._internalLoginStateMayChange)
            .mapTo(Void())
            .startWith(Void())
        let lastAuthedUser = resetCurrentUserTrigger.map({ [weak self] in
            return self?.loadUser()
        }).distinctUntilChanged()
        
        lastAuthedUser.do(onNext: { [weak self] user in
            if let user = user {
                self?.appState.onNext(.goingToAuthorize(DialogUserId(user.userId)!))
                Log.debug("Newly logged in user discovered. Activating \(user)")
                _ = self?.container.setupChildContainer(user: user)
                self?.appState.onNext(.userAuthorized(user))
            } else {
                self?.appState.onNext(.auth)
                Log.debug("No logged in user discovered.")
            }
        }).subscribe().disposed(by: bag)
    }

    private func observeUserEventBusEvents() {
        guard let handler = container.resolve(UserEventBusHandler.self) else {
            return
        }

        handler
            .openProfile
            .do(onNext: { [weak self] user in
                self?.go(to: .profile(user.toPeer()))
            })
            .subscribe()
            .disposed(by: bag)

        handler
            .openDialog
            .do(onNext: { [weak self] peer in
                if peer.type == .group {
                    self?.go(to: .dialogGroup(peer.id))
                } else {
                    self?.go(to: .dialogUser(peer.id))
                }
            })
            .subscribe()
            .disposed(by: bag)
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
    
    private func ensureIdempotentAlertDismissed(_ context: DialogAlertContext,
                                                completion: @escaping () -> ()) {
        var vc: UIViewController? = self.rootViewController
        while vc?.presentedViewController != nil {
            vc = vc?.presentedViewController
        }
        if let id = context.idempotentId,
           let prev = vc as? UIAlertController,
           prev.view.tag == id.rawValue {
            prev.dismiss(animated: false, completion: completion)
        } else {
            completion()
        }
    }
    
    private func setupAlertNotificationObserving() {
        NotificationCenter.default.rx.alertRequests
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (context) in
                self?.ensureIdempotentAlertDismissed(context, completion: { [weak self] in
                    let alert = UIAlertController.fromContext(context)
                    self?.trigger(.present(alert as UIViewController))
                })
            }).disposed(by: bag)
        
        NotificationCenter.default.rx.activityRequests
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (context) in
                self?.trigger(.present(UIActivityViewController.fromContext(context) as UIViewController))
            }).disposed(by: bag)
    }
    
    private func setupUserCoordinator(for user: AuthUserEntry) {
        self.authedUserCoordinator = create(userCoordinatorFor: user)
        Dialog.shared.registerForPushNotifications()
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
        reportWillGo(to: route)
        switch route {
        case .authType:
            let vc = placeholderControllerForNoAuthorizedUser()
            return .set([vc])
        case .global(let globalRoute):
            return self.prepareTransition(for: globalRoute)
        case .present(let controller):
            return .present(controller)
        default:
            return .none()
        }
    }
    
    private func prepareTransition(for authedUserRoute: GlobalAppRoute.AuthedUser) -> ViewTransition {
        return .none()
    }
    
    private func loadDataForRouteToDialog(peer: DialogPeer) -> Maybe<(state: DialogState, unreadCountState: DialogUnreadCountState?)> {
        
        guard let user = authedUserCoordinator?.user,
              let userResolver = container.resolve(SwinjectUserContainersServiceProtocol.self)?.getResolver(user: user),
              let eventBus = userResolver.resolve(EventBusServiceProtocol.self)
        else {
            return .empty()
        }
        
        return eventBus.dialogState(for: peer)
            .take(1)
            .unwrap()
            .flatMap { dialog in
                return eventBus.unreadState(for: peer).map({ (state: dialog, unreadCountState: $0) })
            }
            .take(1)
            .timeout(type(of: self).constants.routeInfoGatheringTimeout, scheduler: MainScheduler.asyncInstance)
            .catchErrorJustComplete()
            .asMaybe()
    }
    
}

// MARK: – Reporting
extension OEMAppCoordinator {
    
    private func reportWillGo(to route: AppRoute) {
        if let globalRoute = mapAppRouteToDialogGlobalRoute(route) {
            NotificationCenter.default.post(name: NSNotification.Name.DialogCoordinationNotification,
                                            object: nil,
                                            userInfo: [Notification.DialogCoordinationUserInfoRouteKey : globalRoute])
            
        }
    }
    
    private func mapAppRouteToDialogGlobalRoute(_ route: AppRoute) -> DialogGlobalRoute? {
        switch route {
        case .global(.user(let subroute)):
            switch subroute.route {
            case .dialogsRoute(let dialogsRoute):
                switch dialogsRoute {
                case .beginSearch:
                    return .searchDialog
                    
                case .dialogs:
                    return .dialogs
                    
                case .dialog(let state, unreadCountState: _, messageId: _):
                    switch state.peer.type {
                    case .group:
                        return .dialogGroup(state.peerId)
                    case .private, .encryptedprivate:
                        return .dialogUser(state.peerId)
                    default:
                        return nil
                    }
                    
                case .userProfile(let args):
                    let peer: DialogPeer
                    if let user = args.initialUser {
                        peer = user.toPeer()
                    } else {
                        peer = .init(type: .private, id: args.id, accessHash: 0)
                    }
                    return .profile(peer)
                    
                case .groupProfile(let args):
                    let peer: DialogPeer
                    if let group = args.initialGroup {
                        peer = group.dialogPeer()
                    } else {
                        peer = .init(type: .group, id: args.id, accessHash: 0)
                    }
                    return .profile(peer)
                    
                case .createDialog:
                    return .createDialog
                    
                default: break
                }
            default: break
            }
        default: break
        }
        return nil
    }
    
}
