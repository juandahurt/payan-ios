//
//  PYPlaceCategory.swift
//  Payan
//
//  Created by Juan Hurtado on 21/05/22.
//

import Foundation

struct PYPlaceCategory: Decodable, Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    var numberOfPlaces: Int
    var deeplink: String
    
    enum CodingKeys: String, CodingKey {
        case image = "image_url"
        case title, numberOfPlaces, deeplink
    }
}

extension PYPlaceCategory {
    static let skeleton: [PYPlaceCategory] = [
        .init(image: "", title: "", numberOfPlaces: 0, deeplink: ""),
        .init(image: "", title: "", numberOfPlaces: 0, deeplink: "")
    ]
}
