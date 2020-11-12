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

    public static func configure(with config: DialogSharedAccessConfig, style: DialogStyle, appName: String) {
        self.shared.shareViewController = ShareExtensionViewController(config: config, style: style, appName: appName)
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

    var config: DialogSharedAccessConfig?

    var style: DialogStyle?

    var extensionAppName: String = "Dialog"

    init(config: DialogSharedAccessConfig, style: DialogStyle, appName: String) {
        self.config = config
        self.style = style
        self.extensionAppName = appName
        super.init()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var appGroup: String? {
        return config?.appGroup
    }

    override var keychainGroup: String? {
        return config?.keychainGroup
    }

    override var appName: String {
        return extensionAppName
    }

    override var primaryTintColor: UIColor {
        return style?.corporateColor ?? .lightGray
    }

    override var avatarColors: [UIColor] {
        return style?.avatarColors ?? []
    }

}
