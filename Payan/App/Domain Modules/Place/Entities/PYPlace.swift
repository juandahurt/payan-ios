//
//  PYPlace.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation

struct PYPlace: Decodable {
    var title: String
    var subtitle: String
    var image: String
    var description: String?
    var images: [PYPlaceImage]
}

extension PYPlace {
    static let empty = PYPlace(title: "", subtitle: "", image: "", images: [])
}
