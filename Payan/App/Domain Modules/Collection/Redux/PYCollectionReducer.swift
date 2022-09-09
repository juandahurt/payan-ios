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
            state = PYCollectionLoadingState(data: .skeleton)
            return environment.worker.getCollection(type: type, categoryId: categoryId)
                .map { data in
                    .setCollection(data)
                }
                .delay(for: 0.5, scheduler: RunLoop.main)
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
