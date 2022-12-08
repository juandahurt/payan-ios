//
//  PYFeedReducer.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 8/12/22.
//

import Combine

class PYFeedReducer: AnyReducer<PYFeedState, PYFeedAction, String> {
    let repository: PYFeedDataAccessLogic
    
    init(repository: PYFeedDataAccessLogic) {
        self.repository = repository
    }
    
    override func update(state: inout PYFeedState, with action: PYFeedAction, environment: String) -> AnyPublisher<PYFeedAction, Never>? {
        switch action {
        case .getData:
            state.isLoading = true
            return repository.getData()
                .map {
                    .showData($0)
                }
                .catch { _ in
                    Empty<PYFeedAction, Never>()
                }
                .eraseToAnyPublisher()
        case .showData(let data):
            state.isLoading = false
            state.placeCategories = data.placeCategories
            return nil
        }
    }
}
