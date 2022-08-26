//
//  PYStorySeenLocalWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 21/08/22.
//

import Foundation

class PYStorySeenLocalWorker: PYStorySeenDataAccessLogic {
    private let userDefaultsKey = "stories_seen"
    
    func getSeenStories() -> [String] {
        UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] ?? []
    }
    
    func setSeenStories(hashes: [String]) {
        UserDefaults.standard.set(hashes, forKey: userDefaultsKey)
    }
}
