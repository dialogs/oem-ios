//
//  Dialog+Style.swift
//  Dialog
//
//  Created by Dmitry Tikhonov on 06.11.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import UIKit
import DialogSharedComponents

public struct DialogStyle {

    public var corporateColor: UIColor

    public var avatarColors: [UIColor]?

    public var dialogBackgroundColor: UIColor?

    public var pinnedDialogBackgroundColor: UIColor?

    public var dialogBackgroundImage: UIImage?

    public var bubbleColors: [BubbleColorKey: UIColor]?

    public enum BubbleColorKey {
        case messageBackgroundColor
        case myMessageBackgroundColor
        case replyIndentLineColor
        case myReplyIndentLineColor
        case textColor
        case myTextColor
        case sentStatusColor
        case readStatusColor
        case dateColor
        case dateWrappedColor
        case authorColor
        case replyTextColor
        case myReplyTextColor
        case voiceMessageControlColor
        case myVoiceMessageControlColor
    }

    public init(corporateColor: UIColor,
                avatarColors: [UIColor]? = nil,
                dialogBackgroundColor: UIColor? = nil,
                pinnedDialogBackgroundColor: UIColor? = nil,
                dialogBackgroundImage: UIImage? = nil,
                bubbleColors: [BubbleColorKey: UIColor]? = nil) {
        self.corporateColor = corporateColor
        self.avatarColors = avatarColors
        self.dialogBackgroundColor = dialogBackgroundColor
        self.pinnedDialogBackgroundColor = pinnedDialogBackgroundColor
        self.dialogBackgroundImage = dialogBackgroundImage
        self.bubbleColors = bubbleColors
    }
}

extension DialogStyle.BubbleColorKey {
    var themeKey: Theme.Keys.MessageBubbles {
        switch self {
        case .messageBackgroundColor:
            return .messageBackgroundColor
        case .myMessageBackgroundColor:
            return .myMessageBackgroundColor
        case .replyIndentLineColor:
            return .replyIndentLineColor
        case .myReplyIndentLineColor:
            return .myReplyIndentLineColor
        case .textColor:
            return .textColor
        case .myTextColor:
            return .myTextColor
        case .sentStatusColor:
            return .sentStatusColor
        case .readStatusColor:
            return .readStatusColor
        case .dateColor:
            return .dateColor
        case .dateWrappedColor:
            return .dateWrappedColor
        case .authorColor:
            return .authorColor
        case .replyTextColor:
            return .replyTextColor
        case .myReplyTextColor:
            return .myReplyTextColor
        case .voiceMessageControlColor:
            return .voiceMessageControlColor
        case .myVoiceMessageControlColor:
            return .myVoiceMessageControlColor
        }
    }
}
