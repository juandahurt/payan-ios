//
//  PYCollectionReducer.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Combine
import Foundation

class PYCollectionReducer: AnyReducer<PYCollectionState, PYCollectionAction, PYCollectionEnvironment> {
    override func update(state: inout PYCollectionState, with action: PYCollectionAction, environment: PYCollectionEnvironment) -> AnyPublisher<PYCollectionAction, Never>? {
        switch action {
        case .setCollection(let collection):
            state = PYCollectionSuccessState(data: collection)
            return nil
        case .getCollection(let type, let categoryId):
//            state = PYCollectionLoadingState()
            return environment.worker.getCollection(type: type, categoryId: categoryId)
                .catch { _ in
                    Empty<PYCollection, Never>()
                }
                .map { data in
                    .setCollection(data)
                }
                .eraseToAnyPublisher()
        }
    }
}
