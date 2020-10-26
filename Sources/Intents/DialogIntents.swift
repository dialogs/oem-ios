//
//  DialogIntents.swift
//  DialogIntents
//
//  Created by Dmitry Tikhonov on 23.10.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Intents
import DialogIntentsExtension

final public class DialogIntents: INExtension {
    
    public static let shared = DialogIntents()
    
    private var intentHandler: IntentHandler?
    
    private override init(){}
    
    public static func configure(keychainGroup: String, appGroup: String) {
        self.shared.intentHandler = IntentHandler(keychainGroup: keychainGroup, appGroup: appGroup)
    }
}

@available(iOS 13.0, *)
extension DialogIntents: INStartCallIntentHandling {
    
    public func handle(intent: INStartCallIntent, completion: @escaping (INStartCallIntentResponse) -> Void) {
        intentHandler?.handle(intent: intent, completion: completion)
    }
    
    public func resolveContacts(for intent: INStartCallIntent, with completion: @escaping ([INStartCallContactResolutionResult]) -> Void) {
        intentHandler?.resolveContacts(for: intent, with: completion)
    }
}

extension DialogIntents: INStartAudioCallIntentHandling {
    
    public func handle(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        intentHandler?.handle(intent: intent, completion: completion)
    }
    
    public func resolveContacts(for intent: INStartAudioCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        intentHandler?.resolveContacts(for: intent, with: completion)
    }
}

extension DialogIntents: INStartVideoCallIntentHandling {
    
    public func handle(intent: INStartVideoCallIntent, completion: @escaping (INStartVideoCallIntentResponse) -> Void) {
        intentHandler?.handle(intent: intent, completion: completion)
    }
    
    public func resolveContacts(for intent: INStartVideoCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        intentHandler?.resolveContacts(for: intent, with: completion)
    }
}

fileprivate class IntentHandler: DialogIntentHandler {
    
    var extensionKeychainGroup: String? = nil
    
    var extensionAppGroup: String? = nil
    
    init(keychainGroup: String?, appGroup: String?) {
        self.extensionKeychainGroup = keychainGroup
        self.extensionAppGroup = appGroup
        super.init()
    }
    
    override var appGroup: String? {
        return extensionAppGroup
    }
    
    override var keychainGroup: String? {
        return extensionKeychainGroup
    }
}
