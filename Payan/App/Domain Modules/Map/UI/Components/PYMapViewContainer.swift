//
//  PYMapViewContainer.swift
//  Payan
//
//  Created by Juan Hurtado on 7/11/22.
//

import Foundation
import SwiftUI
import MapKit

struct PYMapViewContainer: UIViewRepresentable {
    typealias UIViewType = MKMapView
    @EnvironmentObject var store: AppStore<PYMapState, PYMapAction, Any>
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let region = store.state.region
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        if mapView.annotations.isEmpty || store.state.selectedLocation == nil {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(
                store.state.locations.map {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = $0.coordinates
                    return annotation
                }
            )
        }
    }
}

// MARK: - Coordinator implementation (MKMapViewDelegate)
extension PYMapViewContainer {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: PYMapViewContainer
        var lastSelectedAnnotation: MKAnnotation?
        
        init(_ parent: PYMapViewContainer) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }

            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "test")
            annotationView.annotation = annotation
            let image = UIImage(named: PYMapConstants.Images.location)
            annotationView.image = image

            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            if let lastSelectedAnnotation = lastSelectedAnnotation {
                let lastSelectedView = mapView.view(for: lastSelectedAnnotation)
                lastSelectedView?.image = UIImage(named: PYMapConstants.Images.location)
            }
            mapView.setCenter(annotation.coordinate, animated: true)
            let selectedView = mapView.view(for: annotation)
            selectedView?.image = UIImage(named: PYMapConstants.Images.selectedLocation)
            
            guard let selectedLocation = parent.store.state.locations.first(where: {
                $0.coordinates.latitude == annotation.coordinate.latitude && $0.coordinates.longitude == annotation.coordinate.longitude
            }) else {
                return
            }
            parent.store.send(.selectLocation(location: selectedLocation))
            lastSelectedAnnotation = annotation
        }
    }
}

