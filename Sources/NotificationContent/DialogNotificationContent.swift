//
//  DialogNotificationService.swift
//  DialogNotificationContent
//
//  Created by Dmitry Tikhonov on 14.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UserNotificationsUI
import DialogNotificationContentExtension
import DialogSharedComponents

final public class DialogNotificationContent: NSObject, UNNotificationContentExtension {

    public static let shared = DialogNotificationContent()

    private var notificationViewController: NotificationContentExtensionViewController?

    private override init(){}

    public static func configure(with config: DialogSharedAccessConfig, style: DialogStyle) {
        self.shared.notificationViewController = NotificationContentExtensionViewController(config: config, style: style)
    }

    public func didReceive(_ notification: UNNotification) {
        notificationViewController?.didReceive(notification)
    }

    public func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        notificationViewController?.didReceive(response, completionHandler: completion)
    }

    public func embedViewConroller(in containerViewController: UIViewController) {
        guard let controller = notificationViewController else {
            return
        }
        if notificationViewController?.view.superview != nil {
            notificationViewController?.removeFromParent()
            notificationViewController?.view.removeFromSuperview()
        }
        containerViewController.addChild(controller)
        controller.view.frame = containerViewController.view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerViewController.view.addSubview(controller.view)
        controller.didMove(toParent: containerViewController)

        controller.addObserver(self, forKeyPath: "preferredContentSize", options: .new, context: nil)
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "preferredContentSize",
           let value = change?[.newKey] as? CGSize,
           let controller = (object as? NotificationContentExtensionViewController),
           let parent = controller.parent {
            DispatchQueue.main.async {
                parent.preferredContentSize = value
                parent.view.setNeedsLayout()
                parent.view.setNeedsUpdateConstraints()
            }
        }
    }

}

fileprivate class NotificationContentExtensionViewController: DialogNotificationContentExtensionViewController {

    var config: DialogSharedAccessConfig?

    var style: DialogStyle?

    init(config: DialogSharedAccessConfig, style: DialogStyle) {
        self.config = config
        self.style = style
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

    override var bubbleColors: [DialogSharedComponents.Theme.Keys.MessageBubbles: UIColor] {
        guard let colors = style?.bubbleColors else {
            return [:]
        }
        var result = [DialogSharedComponents.Theme.Keys.MessageBubbles: UIColor]()
        for (key, value) in colors {
            result[key.themeKey] = value
        }
        return result
    }

    override var avatarColors: [UIColor] {
        return style?.avatarColors ?? []
    }

}

