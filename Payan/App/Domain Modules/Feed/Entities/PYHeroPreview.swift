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
    
    enum CodingKeys: String, CodingKey {
        case name
        case image = "image_url"
    }
}
