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
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case image = "imageUrl"
    }
}

extension PYHero {
    static let empty = PYHero(name: "", image: "", description: "")
}
