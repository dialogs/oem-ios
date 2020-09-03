//
//  IntentHandler.swift
//  WhiteLabel Intents
//
//  Created by Александр Клёмин on 02.04.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Intents
import DialogIntentsExtension

class IntentHandler: INExtension {
    
    private let dialogIntentHandler = DialogIntentHandler()

}

@available(iOSApplicationExtension 13.0, *)
extension IntentHandler: INStartCallIntentHandling {
    
    func handle(intent: INStartCallIntent, completion: @escaping (INStartCallIntentResponse) -> Void) {
        return dialogIntentHandler.handle(intent: intent, completion: completion)
    }
    
    func resolveContacts(for intent: INStartCallIntent, with completion: @escaping ([INStartCallContactResolutionResult]) -> Void) {
        return dialogIntentHandler.resolveContacts(for: intent, with: completion)
    }
    
}

extension IntentHandler: INStartAudioCallIntentHandling {

    func handle(intent: INStartAudioCallIntent, completion: @escaping (INStartAudioCallIntentResponse) -> Void) {
        return dialogIntentHandler.handle(intent: intent, completion: completion)
    }

    func resolveContacts(for intent: INStartAudioCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        return dialogIntentHandler.resolveContacts(for: intent, with: completion)
    }

}

extension IntentHandler: INStartVideoCallIntentHandling {

    func handle(intent: INStartVideoCallIntent, completion: @escaping (INStartVideoCallIntentResponse) -> Void) {
        return dialogIntentHandler.handle(intent: intent, completion: completion)
    }

    func resolveContacts(for intent: INStartVideoCallIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        return dialogIntentHandler.resolveContacts(for: intent, with: completion)
    }

}
