//
//  PYSearchCoreMockWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Combine
import Foundation

class PYSearchCoreMockWorker: PYSearchCoreDataAccessLogic {
    func fetchResults(from text: String) -> AnyPublisher<[PYSearchResult], Error> {
        Just(())
            .tryMap { Void -> [PYSearchResult] in
                PYSearchResult.dummy
            }
            .delay(for: 1, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
