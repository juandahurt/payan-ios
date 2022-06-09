//
//  PYPlaceLocation.swift
//  Payan
//
//  Created by Juan Hurtado on 2/06/22.
//

import Foundation
import MapKit

struct PYPlaceLocation: Identifiable, Decodable {
    let id: UUID
    let coordinates: CLLocationCoordinate2D
    
    enum CodingKeys: CodingKey {
        case lat, lon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        let lat = try container.decode(Double.self, forKey: .lat)
        let lon = try container.decode(Double.self, forKey: .lon)
        coordinates = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )
    }
    
    init() {
        id = UUID()
        coordinates = CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        )
    }
}
