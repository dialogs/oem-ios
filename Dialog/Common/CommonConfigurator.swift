//
//  CommonConfigurator.swift
//  Dialog
//
//  Created by Александр Клёмин on 28.08.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import TrustKit
import UIKit
import DialogSharedComponents

class CommonConfigurator {
    
    static let corporateColor = #colorLiteral(red: 0.5960784314, green: 0.5333333333, blue: 0.768627451, alpha: 1)
    let corporateColor = CommonConfigurator.corporateColor
    
    static let avatarColors = [#colorLiteral(red: 0.6980392157, green: 0.6588235294, blue: 0.8117647059, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.8156862745, blue: 0.368627451, alpha: 1), #colorLiteral(red: 0.8509803922, green: 0.6352941176, blue: 0.7764705882, alpha: 1), #colorLiteral(red: 0.4745098039, green: 0.7803921569, blue: 0.8196078431, alpha: 1), #colorLiteral(red: 0.9254901961, green: 0.6941176471, blue: 0.6941176471, alpha: 1), #colorLiteral(red: 0.5176470588, green: 0.6784313725, blue: 0.8549019608, alpha: 1), #colorLiteral(red: 0.9176470588, green: 0.5529411765, blue: 0.5294117647, alpha: 1), #colorLiteral(red: 0.662745098, green: 0.8470588235, blue: 0.6862745098, alpha: 1)]
    let avatarColors = CommonConfigurator.avatarColors
    
    let bubbleColors: KeyValuePairs<Theme.Keys.MessageBubbles, UIColor> = [
        .myMessageBackgroundColor: CommonConfigurator.corporateColor
    ]
    
    let useSslPinning = false
    
    func configureTrustKit() {
        TrustKit.initSharedInstance(withConfiguration: [:])
    }
    
}
