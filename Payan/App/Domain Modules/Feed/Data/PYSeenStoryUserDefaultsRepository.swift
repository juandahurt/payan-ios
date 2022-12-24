//
//  PYSeenStoryUserDefaultsRepository.swift
//  Payan
//
//  Created by Juan Hurtado on 24/12/22.
//

import Foundation
 
class PYSeenStoryUserDefaultsRepository: PYSeenStoryRepository {
    private let userDefaultsKey = "stories_seen"
    
    func setSeenStories(_ hashes: [String]) {
        UserDefaults.standard.set(hashes, forKey: userDefaultsKey)
    }
    
    func getSeenStories() -> [String] {
        UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] ?? []
    }
}
