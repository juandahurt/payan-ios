//
//  PYMainBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 24/06/22.
//

import Foundation

protocol PYMainBusinessLogic {
    func checkIfUserHasSeenOnboarding() -> Bool
    func saveUserSawOnboarding()
}
