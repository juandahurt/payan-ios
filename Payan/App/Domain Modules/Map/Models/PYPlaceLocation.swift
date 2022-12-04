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
    let imageUrl: String
    let title: String
    let coordinates: CLLocationCoordinate2D
    let link: String
    
    enum CodingKeys: CodingKey {
        case title, imageUrl, location, link
    }
    
    enum LocationCodingKeys: CodingKey {
        case lat, lon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        title = try container.decode(String.self, forKey: .title)
        link = try container.decode(String.self, forKey: .link)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .location)
        let lat = try locationContainer.decode(Double.self, forKey: .lat)
        let lon = try locationContainer.decode(Double.self, forKey: .lon)
        coordinates = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )
    }
}
