//
//  PYMainLocalWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 24/06/22.
//

import Foundation

class PYMainLocalWorker: PYMainDataAccessLogic {
    private let userDefaultsKey = "user_has_seen_onboarding"
    
    func getUserHasSeenOnboarding() -> Bool {
        UserDefaults.standard.value(forKey: userDefaultsKey) as? Bool ?? false
    }
    
    func saveUserSawOnboarding() {
        UserDefaults.standard.set(true, forKey: userDefaultsKey)
    }
}
