//
//  PYPlaceCategory.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation

struct PYPlaceCategory: Decodable {
    var image: String
    var title: String
    var numberOfPlaces: Int
    
    enum CodingKeys: String, CodingKey {
        case image = "image_url"
        case title, numberOfPlaces
    }
}
