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
public final class DialogRootController: UINavigationController {
    
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
            .notification(Dialog.DialogDidUpdateBadgesStateNotification).map({ (notification) -> String? in
                guard let state = notification
                        .userInfo?[Dialog.BadgesState.notificationUserInfoKey] as? Dialog.BadgesState else {
                    return nil
                }
                return state.unreadDialogs > 0 ? String(state.unreadDialogs) : nil
            })
            .subscribe().disposed(by: bag)
    }
    
}
