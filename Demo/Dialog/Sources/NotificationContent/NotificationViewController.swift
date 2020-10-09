//
//  NotificationViewController.swift
//  WhiteLabel Notification Content
//
//  Created by Александр Клёмин on 01.04.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import DialogNotificationContentExtension
import DialogSharedComponents

class NotificationViewController: DialogNotificationContentExtensionViewController {

    private let configurator = CommonConfigurator()

    override var bubbleColors: KeyValuePairs<DialogSharedComponents.Theme.Keys.MessageBubbles, UIColor> {
        return configurator.bubbleColors
    }

    override var avatarColors: [UIColor] {
        return configurator.avatarColors
    }
    
}
