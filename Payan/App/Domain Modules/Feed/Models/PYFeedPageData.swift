//
//  PYFeedPageData.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation

struct PYFeedPageData: Decodable {
    var placeCategories: [PYPlaceCategory]
    var heroes: [PYHeroPreview]
    var stories: [PYStoryPreview]
}

extension PYFeedPageData {
    static let empty = PYFeedPageData(placeCategories: [], heroes: [], stories: [])
}
