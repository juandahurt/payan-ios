//
//  PYOnboardingDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 30/07/22.
//

import Foundation

protocol PYOnboardingDataAccessLogic {
    /// It fetches all the items.
    /// - Returns: The list of items.
    func fetchItems() -> [PYOnboardingItem]
}
