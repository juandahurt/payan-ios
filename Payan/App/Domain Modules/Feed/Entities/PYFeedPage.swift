//
//  PYFeedPage.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation

struct PYFeedPage: Decodable {
    var placeCategories: [PYPlaceCategory]
}

extension PYFeedPage {
    static let empty = PYFeedPage(placeCategories: [])
}
