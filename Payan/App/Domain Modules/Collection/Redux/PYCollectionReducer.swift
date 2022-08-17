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
            state = PYCollectionLoadingState()
            return environment.worker.getCollection(type: type, categoryId: categoryId)
//                .delay(for: 4, scheduler: RunLoop.main)
                .map { data in
                    .setCollection(data)
                }
                .tryCatch { _ in
                    Just(PYCollectionAction.errorOcurred)
                        .delay(for: 1, scheduler: RunLoop.main)
                }
                .catch { _ in
                    Empty<PYCollectionAction, Never>()
                }
                .eraseToAnyPublisher()
        case .errorOcurred:
            state = PYCollectionErrorState("Hubo un error desconocido.")
            return nil
        }
    }
}
