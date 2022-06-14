//
//  PYHeroPreview.swift
//  Payan
//
//  Created by Juan Hurtado on 24/05/22.
//

import Foundation

struct PYHeroPreview: Decodable {
    var name: String
    var image: String
    var description: String
    var deepLink: String
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case deepLink = "deeplink"
        case image = "image_url"
    }
}
