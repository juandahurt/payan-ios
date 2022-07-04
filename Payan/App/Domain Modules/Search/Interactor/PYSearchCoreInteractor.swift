//
//  PYSearchCoreInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Combine
import Foundation

class PYSearchCoreInteractor: PYSearchCoreBusinessLogic {
    private var worker: PYSearchCoreDataAccessLogic
    
    init(worker: PYSearchCoreDataAccessLogic) {
        self.worker = worker
    }
    
    func search(text: String) -> AnyPublisher<[PYSearchResult], Error> {
        worker.fetchResults(from: text)
    }
}
