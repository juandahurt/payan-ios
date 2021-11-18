//
//  Place.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation

struct Place: Decodable {
    var name: String
    var type: PlaceCategory
    var imageUrl: String = "https://media.traveler.es/photos/61376f8bd4923f67e298ef5b/master/w_1600,c_limit/130738.jpg"
    var description: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name, description
        case imageUrl = "image"
        case type = "category"
    }
}

enum PlaceCategory: String, Decodable {
    case museum = "MUSEUM"
    case park = "PARK"
    case bridge = "BRIDGE"
    case church = "CHURCH"
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
