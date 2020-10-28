//
//  OEMCoordination.swift
//  Dialog
//
//  Created by Gordeev Aleksey on 28.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Foundation
import DialogProtocols

public extension Notification.Name {
    /// Listening the Dialog routing. Contains `DialogGlobalRoute` in user info. See `DialogCoordinationUserInfoRouteKey`.
    static let DialogCoordinationNotification = Notification.Name(rawValue: "im.dlg.dialog.coordination")
}

public extension Notification {
    
    /// The key to get a DialogGlobalRoute instance from the `DialogCoordinationNotification` notification user info
    static let DialogCoordinationUserInfoRouteKey = "im.dlg.dialog.coordination.userInfo.route"
    
}

/// Simplified version of GlobalAppRoute
public enum DialogGlobalRoute {
    
    case dialogs
    case dialogGroup(DialogGroupId)
    case dialogUser(DialogUserId)
    case createDialog
    case searchDialog
    case profile(DialogPeer)
    
}
