//
//  PYMainDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 24/06/22.
//

import Foundation

protocol PYMainDataAccessLogic {
    func getUserHasSeenOnboarding() -> Bool
    func saveUserSawOnboarding()
}
