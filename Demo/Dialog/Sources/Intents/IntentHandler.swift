//
//  IntentHandler.swift
//  DialogDemo Intents
//
//  Created by Александр Клёмин on 07.09.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Intents
import DialogIntents

class IntentHandler: INExtension {
    
    override init() {
        super.init()
        
        if let appGroup = Bundle.main.object(forInfoDictionaryKey: "App group") as? String, let keychainGroup = Bundle.main.object(forInfoDictionaryKey: "Keychain access group") as? String {
            DialogIntents.configure(with: DialogSharedAccessConfig(appGroup: appGroup, keychainGroup: keychainGroup))
        }
    }
    
}

@available(iOSApplicationExtension 13.0, *)
extension IntentHandler: INStartCallIntentHandling {
    
    func handle(intent: INStartCallIntent, completion: @escaping (INStartCallIntentResponse) -> Void) {
        return DialogIntents.shared.handle(intent: intent, completion: completion)
    }
    
    func resolveContacts(for intent: INStartCallIntent, with completion: @escaping ([INStartCallContactResolutionResult]) -> Void) {
        return DialogIntents.shared.resolveContacts(for: intent, with: completion)
    }
    
}

extension IntentHandler: INStartAudioCallIntentHandling {

    func handle(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        return DialogIntents.shared.handle(intent: intent, completion: completion)
    }

    func resolveContacts(for intent: INStartAudioCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        return DialogIntents.shared.resolveContacts(for: intent, with: completion)
    }
    
}

extension IntentHandler: INStartVideoCallIntentHandling {

    func handle(intent: INStartVideoCallIntent, completion: @escaping (INStartVideoCallIntentResponse) -> Void) {
        return DialogIntents.shared.handle(intent: intent, completion: completion)
    }

    func resolveContacts(for intent: INStartVideoCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        return DialogIntents.shared.resolveContacts(for: intent, with: completion)
    }
    
}
