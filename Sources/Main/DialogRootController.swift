//
//  DialogRootController.swift
//  Dialog
//
//  Created by Gordeev Aleksey on 26.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Dialog_iOS

/// TODO: Make inherited from the DUINavigationController
open class DialogRootController: UINavigationController {
    
    private let bag = DisposeBag()
    
    public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        
        commonInit()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        commonInit()
    }
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        Dialog.shared.container.register(DialogRootController.self) { _ in
            return self
        }
        _ = Dialog.shared.container.resolve(OEMAppCoordinator.self)
        NotificationCenter.default.rx
            .notification(Dialog.DialogDidUpdateBadgesStateNotification).map({ (notification) -> Dialog.BadgesState? in
                return notification.userInfo?[Dialog.BadgesState.notificationUserInfoKey] as? Dialog.BadgesState
            })
            .do(onNext: { [weak self] (state) in
                self?.updateBadge(state: state)
            })
            .subscribe().disposed(by: bag)
        onAfterInit()
    }
    
    /// Calls right after the instance initied. Override this method to do what you need without the requirement to override constructors
    open func onAfterInit() {
        
    }
    
    /// Updates the badge with the given badge sate. Override this method to customize value or ignore it
    open func updateBadge(state: Dialog.BadgesState?) {
        let value: String? = {
            guard let state = state else {
                return nil
            }
            return state.unreadDialogs > 0 ? String(state.unreadDialogs) : nil
        }()
        self.tabBarItem?.badgeValue = value
    }
    
}
