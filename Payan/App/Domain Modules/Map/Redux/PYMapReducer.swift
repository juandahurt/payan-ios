//
//  PYMapReducer.swift
//  Payan
//
//  Created by Juan Hurtado on 30/10/22.
//

import CoreLocation
import Combine
import Foundation

class PYMapReducer: AnyReducer<PYMapState, PYMapAction, Any> {
    private let repository: PYMapDataAccessLogic
    private var disposeBag = Set<AnyCancellable>()
    private let minimumLoadingTime = 1.0
    private let locationManager = CLLocationManager()
    
    init(repository: PYMapDataAccessLogic) {
        self.repository = repository
    }
    
    override func update(state: inout PYMapState, with action: PYMapAction, environment: Any) -> AnyPublisher<PYMapAction, Never>? {
        switch action {
        case .getLocations:
            let holderPub = Just<[PYPlaceLocation]>([])
                .delay(for: .init(minimumLoadingTime), scheduler: RunLoop.main)
            
            let locationsPub = repository.getPlacesLocations()
                .receive(on: RunLoop.main)
                .catch { _ in
                    Empty<[PYPlaceLocation], Never>()
                }
            
            return holderPub.combineLatest(locationsPub)
                .map { data in
                        .setLocations(data: data.1)
                }
                .eraseToAnyPublisher()
        case .setLocations(let data):
            state.isLoading = false
            state.locations = data
            return nil
        case .selectLocation(let location):
            state.selectedLocation = location
            return nil
        case .errorOccured:
            state.isLoading = false
            state.errorOccured = true
            return nil
        case .requestAuth:
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            return nil
        }
    }
}
