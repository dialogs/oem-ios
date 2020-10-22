//
//  DialogShareExtension.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 20.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import DialogShareExtension

final public class DialogShare {

    public static let shared = DialogShare()

    private var shareViewController: ShareExtensionViewController?

    private init(){}

    public static func configure(keychainGroup: String, appGroup: String, appName: String) {
        self.shared.shareViewController = ShareExtensionViewController(keychainGroup: keychainGroup, appGroup: appGroup, appName: appName)
    }

    public func embedViewConroller(in containerViewController: UIViewController) {
        guard let controller = shareViewController else {
            return
        }
        if controller.view.superview != nil {
            controller.removeFromParent()
            controller.view.removeFromSuperview()
        }
        containerViewController.addChild(controller)
        controller.view.frame = containerViewController.view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerViewController.view.addSubview(controller.view)
        controller.didMove(toParent: containerViewController)
    }
}

fileprivate class ShareExtensionViewController: DialogShareExtensionController {

    var extensionKeychainGroup: String? = nil

    var extensionAppGroup: String? = nil

    var extensionAppName: String = "Dialog"

    init(keychainGroup: String?, appGroup: String?, appName: String) {
        self.extensionKeychainGroup = keychainGroup
        self.extensionAppGroup = appGroup
        self.extensionAppName = appName
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var appGroup: String? {
        return extensionAppGroup
    }

    override var keychainGroup: String? {
        return extensionKeychainGroup
    }

    override var appName: String {
        return extensionAppName
    }

}
