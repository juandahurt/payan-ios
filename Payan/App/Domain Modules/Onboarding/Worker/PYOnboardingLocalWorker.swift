//
//  PYOnboardingLocalWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 30/07/22.
//

import Foundation

class PYOnboardingLocalWorker: PYOnboardingDataAccessLogic {
    func fetchItems() -> [PYOnboardingItem] {
        guard let url = Bundle.main.url(forResource: "OnboardingItems", withExtension: "plist") else {
            return []
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return []
        }
        
        let decoder = PropertyListDecoder()
        guard let items = try? decoder.decode([PYOnboardingItem].self, from: data) else { return [] }
        return items
    }
}
