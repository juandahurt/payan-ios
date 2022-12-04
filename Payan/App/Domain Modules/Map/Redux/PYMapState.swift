//
//  PYMapState.swift
//  Payan
//
//  Created by Juan Hurtado on 30/10/22.
//

import MapKit
import Foundation

class PYMapState {
    var isLoading = true
    var locations: [PYPlaceLocation] = []
    var selectedLocation: PYPlaceLocation?
    var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: PYMapConstants.InitialLocation.lat,
                                       longitude: PYMapConstants.InitialLocation.lon),
        latitudinalMeters: 1500,
        longitudinalMeters: 1500
    )
    var errorOccured = false
}
