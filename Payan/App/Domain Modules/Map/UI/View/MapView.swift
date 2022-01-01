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
            latitudeDelta: 0.035,
            longitudeDelta: 0.035
        )
    )
    @ObservedObject private var presenter: MapPresenter
    @State private var selectedPlace: Place?
    
    init(presenter: MapPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        GeometryReader { geometry in
            Map(coordinateRegion: $region, annotationItems: presenter.places) { place in
                MapAnnotation(
                    coordinate: place.coordinate,
                    anchorPoint: .init(x: 0.5, y: 0.5)
                ) {
                    PlaceAnnotationView(category: place.type) {
                        selectedPlace = place
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
            if let place = selectedPlace {
                VStack {
                    Spacer()
                    HStack {
                        Spacer(minLength: 0)
                        SelectedPlaceView(in: geometry.size, place: place, seeMoreOnTap: {
                            presenter.showPlace(place)
                        }) {
                            selectedPlace = nil
                        }
                            .frame(width: geometry.size.width - 30, height: geometry.size.height / 3)
                        Spacer(minLength: 0)
                    }
                }
            }
        }
    }
}
