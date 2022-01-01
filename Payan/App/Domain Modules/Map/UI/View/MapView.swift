//
//  MapView.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 2.4448,
            longitude: -76.6147
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2
        )
    )
    @ObservedObject private var presenter: MapPresenter
    
    init(presenter: MapPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: presenter.places) { place in
            MapAnnotation(
                coordinate: place.coordinate,
                anchorPoint: .init(x: 0.5, y: 0.5)
            ) {
                PlaceAnnotationView(category: place.type) {
                    withAnimation(.easeIn) {
                        region.center = place.coordinate
                    }
                }
            }
        }
            .onAppear {
                if presenter.places.isEmpty {
                    presenter.getPlaces()
                }
            }
            .colorScheme(.dark)
    }
}
