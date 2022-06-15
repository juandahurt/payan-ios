//
//  PYHero.swift
//  Payan
//
//  Created by Juan Hurtado on 14/06/22.
//

import Foundation

struct PYHero: Decodable {
    var name: String
    var image: String
    var description: String
    var sections: [PYHeroSection]
    
    enum CodingKeys: String, CodingKey {
        case name, description, sections
        case image = "imageUrl"
    }
}

extension PYHero {
    static let empty = PYHero(name: "", image: "", description: "", sections: [])
}
