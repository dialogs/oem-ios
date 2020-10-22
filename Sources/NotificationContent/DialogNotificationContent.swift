//
//  DialogNotificationService.swift
//  DialogNotificationContent
//
//  Created by Dmitry Tikhonov on 14.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UserNotificationsUI
import DialogNotificationContentExtension

final public class DialogNotificationContent: NSObject, UNNotificationContentExtension {

    public static let shared = DialogNotificationContent()

    private var notificationViewController: NotificationContentExtensionViewController?

    private override init(){}

    public static func configure(keychainGroup: String, appGroup: String) {
        self.shared.notificationViewController = NotificationContentExtensionViewController(keychainGroup: keychainGroup, appGroup: appGroup)
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

    var extensionKeychainGroup: String? = nil

    var extensionAppGroup: String? = nil

    init(keychainGroup: String?, appGroup: String?) {
        self.extensionKeychainGroup = keychainGroup
        self.extensionAppGroup = appGroup
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
}

