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
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case name, image
        case type = "category"
    }
    
    init(name: String, type: PlaceCategory) {
        self.name = name
        self.type = type
        image = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(PlaceCategory.self, forKey: .type)
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
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
