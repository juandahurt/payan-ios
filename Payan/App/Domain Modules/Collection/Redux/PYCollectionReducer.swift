//
//  PYCollectionReducer.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Combine
import Foundation

class PYCollectionReducer: AnyReducer<PYCollectionState, PYCollectionAction> {
    var worker: PYCollectionDataAccessLogic
    
    init(worker: PYCollectionDataAccessLogic) {
        self.worker = worker
    }
    
    override func update(state: inout PYCollectionState, with action: PYCollectionAction) -> AnyPublisher<PYCollectionAction, Never>? {
        switch action {
        case .setCollection(let collection):
            state = PYCollectionSuccessState(data: collection)
            return nil
        case .getCollection(let type, let categoryId):
            state = PYCollectionLoadingState()
            return worker.getCollection(type: type, categoryId: categoryId)
                .map { data in
                    .setCollection(data)
                }
                .tryCatch { _ in
                    Just(PYCollectionAction.errorOcurred)
                }
                .catch { _ in
                    Empty<PYCollectionAction, Never>()
                }
                .eraseToAnyPublisher()
        case .errorOcurred:
            state.errorHasOcurred = true
            return nil
        }
    }
}
