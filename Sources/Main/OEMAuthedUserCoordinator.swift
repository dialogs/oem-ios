//
//  OEMAuthedUserCoordinator.swift
//  Dialog
//
//  Created by Gordeev Aleksey on 23.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import XCoordinator
import Dialog_iOS
import DialogProtocols
import Swinject

import RxSwift


extension GlobalAppRoute.AuthedUser.Route: Route {}

internal final class OEMAuthedUserCoordinator: NavigationCoordinator<GlobalAppRoute.AuthedUser.Route> {
    
    public let user: AuthUserEntry
    
    public let container: Swinject.Container
    
    public init(user: AuthUserEntry,
                rootViewController: UINavigationController,
                container: Swinject.Container,
                initialRoute: GlobalAppRoute.AuthedUser.Route? = nil) {
        self.user = user
        self.container = container
        super.init(rootViewController: rootViewController, initialRoute: initialRoute)
    }
    
    private func prepareTransition(for route: ContactsRoute) -> NavigationTransition {
        switch route {
        case .main:
            let vc = container.resolveSceneViewController(ContactsListScene.self.self, resolver: container)!
            return .push(vc)
            
        case .userProfile(let args):
            let route = DialogsRoute.userProfile(args)
            return self.prepareTransition(for: route)
        }
    }
    
    @objc private func openContacts() {
        self.trigger(.contactsRoute(.main))
    }
    
    private func prepareTransition(for route: DialogsRoute) -> NavigationTransition {
        Log.debug("OEM user coordinator prepare transition for \(route)")
        switch route {
        case .dialogs:
            let dialogsVC = container.resolveSceneViewController(DialogsListScene.self, resolver: container)!
            return .set([dialogsVC])
            
        case .userProfile(let arguments):
            typealias Scene = PublicProfileScene
            let arg = Scene.Argument(main: UserProfileSceneArgument(routeArgument: arguments))
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
            
        case .createDialog:
            let fabric = container.resolve(CoordinatorFabricProtocol.self)!
            let coordinator: AnyCreateDialogCoordinator = fabric.create(parentContainer: container,
                                                                        arg: rootViewController)
            addChild(coordinator)
            return .none()

        case .groupProfile(let args):
            typealias Scene = GroupProfileScene
            var mainArg = Scene.Argument.MainArgument(id: args.id)
            mainArg.initialGroup = args.initialGroup
            let arg = Scene.Argument(main: mainArg)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
            
        case .dialog(let state, unreadCountState: let unread, messageId: let mid):
            guard let dialogsController = self.rootViewController.viewControllers.first else {
                return .none()
            }
            
            typealias Scene = ConversationScene
            
            let main = Scene.Argument.MainArgument(dialogState: state,
                                                   unreadCountState: unread,
                                                   initialPeer: nil,
                                                   messageId: mid)
            let arg = Scene.Argument(main: main)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            
            return throughNavigationBehavior(forRoute: route, withTransition: .set([dialogsController, vc]))
            
        case .searchResultsDialog(let dialog, unreadCountState: let unreadState, peer: let peer):
            guard let dialogsController = self.rootViewController.viewControllers.first else {
                return .none()
            }
            
            typealias Scene = ConversationScene
            
            let main = ConversationScene.Argument.MainArgument(dialogState: dialog,
                                                               unreadCountState: unreadState,
                                                               initialPeer: peer)
            let arg = Scene.Argument(main: main)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .set([dialogsController, vc])
            
        case .beginSearch:
            let responsibleViewController = rootViewController
                .navigationController?
                .viewControllers
                .lazy
                .compactMap({ $0 as? DialogSearchableInterface})
                .first

            if let viewController = responsibleViewController {
                viewController.beginSearch()
            }
            return .none()
            
        case .doneInvite:
            return .pop()
            
        case .leaveGroup:
            return .popToRoot()
            
        case .popFromMultiforward:
            if let deselectable = self.rootViewController
                .viewControllers
                .reversed()
                .compactMap({ $0 as? ConversationViewMessageSelectionProtocol })
                .first {
                deselectable.deselectAllMessages()
            }
            return .pop()
            
        case .pushFromMultiforward(let state):
            guard let dialogsController = self.rootViewController.viewControllers.first else {
                return .none()
            }
            
            typealias Scene = ConversationScene
            
            let main = ConversationScene.Argument.MainArgument(dialogState: state,
                                                               unreadCountState: nil,
                                                               initialPeer: nil)
            let arg = Scene.Argument(main: main)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .set([dialogsController, vc])
            
        case .chooseForwardTarget(messages: let messages):
            typealias Scene = ForwardTargetsListScene
            
            let source = ForwardTargetsListSource(messages: messages)
            let arg = Scene.Argument(main: source)
            let vc = container.resolveSceneViewController(MultiForwardTargetListScene.self,
                                                          arg: arg,
                                                          resolver: container)!
            vc.hidesBottomBarWhenPushed = true
            return .push(vc)
            
        case .webView(goToLink: let url):
            typealias Scene = WebViewScene
            let arg = Scene.Argument(main: url)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            if #available(iOS 13, *) {
                return .present(vc)
            }
            return .push(vc)
            
        case .open(previewInfo: let previewInfo):
            typealias Scene = DUIPreviewScene
            let arg = Scene.Argument(main: previewInfo)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .present(vc)
            
        case .showAttachments(ofPeer: let conversationPeer):
            typealias Scene = AttachmentsScene
            let arg = Scene.Argument(main: conversationPeer)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
            
        case .createAvc:
            typealias Scene = CreateNewConferenceScene
            let vc = container.resolveSceneViewController(Scene.self, resolver: container)!
            return .push(vc)
            
        case .selectUserForOwner(let groupId, let userSelectionHandler, let cancelHandler):
            typealias Scene = SelectUserInGroupScene
            
            let arg = Scene.Argument(main: (groupId, userSelectionHandler, cancelHandler))
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
            
        case .selectUserForPermissions(let groupId, let userSelectionHandler):
            typealias Scene = SelectUserInGroupScene
            
            let arg = Scene.Argument(main: (groupId, userSelectionHandler, {}))
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
        
        case .changePermissions(let groupId, let userId):
            typealias Scene = GroupPermissionsScene
            let arg = Scene.Argument(main: GroupAndUser(groupId: groupId, userId: userId))
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
            
        case .doneTransferOwnership:
            guard let index = rootViewController.viewControllers.firstIndex(where: { $0 is GroupRepresentableViewController }) else {
                return .popToRoot()
            }
            return .pop(to: rootViewController.viewControllers[index])
            
        case .groupLink(let groupId, let linkType):
            typealias Scene = GroupLinkScene
            let arg = Scene.Argument(main: (groupId, linkType))
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
            
        case .groupInvite(let id):
            typealias Scene = InviteUsersToGroupScene
            let arg = Scene.Argument(main: id)
            let vc = container.resolveSceneViewController(Scene.self, arg: arg, resolver: container)!
            return .push(vc)
        }
    }

    private func throughNavigationBehavior(forRoute route: DialogsRoute,
                                        withTransition transition: NavigationTransition) -> NavigationTransition {
        
        defer {
            switch route {
            case .dialog, .searchResultsDialog:
                if rootViewController.navigationBar.isHidden {
                    rootViewController.setNavigationBarHidden(false, animated: false)
                }
                
                guard let notInStackViewController = self.rootViewController.presentedViewController else {
                    break
                }
                notInStackViewController.dismiss(animated: false)
                
            default:
                break
            }
        }
        return transition
    }
    
    internal override func prepareTransition(for route: GlobalAppRoute.AuthedUser.Route) -> NavigationTransition {
        switch route {
        case .dialogsRoute(let dialogsRoute):
            return prepareTransition(for: dialogsRoute)
        case .contactsRoute(let contactsRoute):
            return prepareTransition(for: contactsRoute)
        default:
            return .none()
        }
    }
}
