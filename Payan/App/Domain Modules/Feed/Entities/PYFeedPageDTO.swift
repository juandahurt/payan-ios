//
//  PYFeedPageDTO.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation

struct PYFeedPageDTO: Decodable {
    var placeCategories: [PYPlaceCategory]
}

extension PYFeedPageDTO {
    static let empty = PYFeedPageDTO(placeCategories: [])
}
