//
//  PYSeenStoryRepository.swift
//  Payan
//
//  Created by Juan Hurtado on 24/12/22.
//

import Foundation

protocol PYSeenStoryRepository {
    func setSeenStories(_ hashes: [String])
    func getSeenStories() -> [String]
}
