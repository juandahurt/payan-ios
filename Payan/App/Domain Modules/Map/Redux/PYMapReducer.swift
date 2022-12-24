//
//  PYMapReducer.swift
//  Payan
//
//  Created by Juan Hurtado on 30/10/22.
//

import CoreLocation
import Combine
import Foundation

class PYMapReducer: AnyReducer<PYMapState, PYMapAction> {
    private let repository: PYMapDataAccessLogic
    private var disposeBag = Set<AnyCancellable>()
    private let minimumLoadingTime = 1.0
    private let locationManager = CLLocationManager()
    
    init(repository: PYMapDataAccessLogic) {
        self.repository = repository
    }
    
    override func update(state: inout PYMapState, with action: PYMapAction) -> AnyPublisher<PYMapAction, Never>? {
        switch action {
        case .getLocations:
            state.errorOccured = false
            state.isLoading = true
            let holderPub = Just<[PYPlaceLocation]>([])
                .delay(for: .init(minimumLoadingTime), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
            let locationsPub = repository.getPlacesLocations()
                .receive(on: RunLoop.main)
            
            return holderPub.combineLatest(locationsPub)
                .map { data in
                        .setLocations(data: data.1)
                }
                .catch { _ -> Just<PYMapAction> in
                    Just<PYMapAction>(.errorOccured)
                }
                .eraseToAnyPublisher()
        case .setLocations(let data):
            state.isLoading = false
            state.locations = data
            state.errorOccured = false
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
