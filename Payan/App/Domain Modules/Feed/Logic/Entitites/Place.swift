//
//  Place.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation
import CoreLocation

struct Place: Decodable, Identifiable {
    var id: String = UUID().uuidString
    var code: String = ""
    var name: String
    var type: PlaceCategory
    var imageUrl: String = "https://media.traveler.es/photos/61376f8bd4923f67e298ef5b/master/w_1600,c_limit/130738.jpg"
    var description: String = ""
    var foundationYear: String = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    enum CodingKeys: String, CodingKey {
        case name, description, foundationYear, code, lat, lon
        case imageUrl = "image"
        case type = "category"
    }
    
    init(name: String, type: PlaceCategory) {
        self.name = name
        self.type = type
        self.coordinate = CLLocationCoordinate2D(latitude: .random(in: 2.4...2.445), longitude: -76.6147)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(PlaceCategory.self, forKey: .type)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        description = try container.decode(String.self, forKey: .description)
        foundationYear = try container.decode(String.self, forKey: .foundationYear)
        
        let lat = try? container.decode(Double.self, forKey: .lat)
        let lon = try? container.decode(Double.self, forKey: .lon)
        if let lat = lat, let lon = lon {
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
    }
}

enum PlaceCategory: String, Decodable {
    case museum = "MUSEUM"
    case park = "PARK"
    case bridge = "BRIDGE"
    case church = "CHURCH"
}

#if DEBUG
// MARK: - Dummy data
extension Place {
    static let dummyMuseums = [
        Place(name: "Museo de arte religioso", type: .museum),
        Place(name: "Museo de ciencias naturales", type: .museum),
        Place(name: "Casa museo Guillero León Valencia", type: .museum)
    ]
}
#endif
