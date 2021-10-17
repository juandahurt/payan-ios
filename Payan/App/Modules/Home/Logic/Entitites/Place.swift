//
//  Place.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation

struct Place {
    var name: String
    var type: PlaceType
}

enum PlaceType: Int {
    case museum = 0
    case park = 1
    case bridge = 2
    case church = 3
}

// MARK: - Dummy data
extension Place {
    static let dummyList = [
        Place(name: "Lugar 1", type: .museum),
        Place(name: "Lugar 2", type: .bridge),
        Place(name: "Lugar 3", type: .park)
    ]
}
