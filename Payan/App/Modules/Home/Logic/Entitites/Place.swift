//
//  Place.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation

struct Place {
    var name: String
    var type: PlaceCategory
    var imageUrl: String = "https://media.traveler.es/photos/61376f8bd4923f67e298ef5b/master/w_1600,c_limit/130738.jpg"
}

enum PlaceCategory: Int {
    case museum = 0
    case park = 1
    case bridge = 2
    case church = 3
}

// MARK: - Dummy data
extension Place {
    static let dummyFavorites = [
        Place(name: "Casa museo Guillero León Valencia", type: .museum),
        Place(name: "Puente viejo", type: .bridge),
        Place(name: "Parque Caldas", type: .park)
    ]
    
    static let dummyMuseums = [
        Place(name: "Museo de arte religioso", type: .museum),
        Place(name: "Museo de ciencias naturales", type: .museum),
        Place(name: "Casa museo Guillero León Valencia", type: .museum)
    ]
}
