//
//  PYMapReducer.swift
//  Payan
//
//  Created by Juan Hurtado on 30/10/22.
//

import Combine
import Foundation

final class PYMapReducer: AnyReducer<PYMapState, PYMapAction, Any> {
    let repository: PYMapDataAccessLogic
    
    private let minimumLoadingTime = 1.0
    
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
        }
    }
}
