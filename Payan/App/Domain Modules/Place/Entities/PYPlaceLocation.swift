//
//  PYPlaceLocation.swift
//  Payan
//
//  Created by Juan Hurtado on 2/06/22.
//

import Foundation
import MapKit

struct PYPlaceLocation: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), lat: Double, lon: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )
    }
}
