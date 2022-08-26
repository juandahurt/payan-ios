//
//  PYSearchNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 4/07/22.
//

import Combine
import Foundation

class PYSearchNetworkWorker: PYSearchCoreDataAccessLogic {
    func fetchResults(from text: String) -> AnyPublisher<[PYSearchResult], Error> {
        let request = PYNetworkRequest(endpoint: "search?q=\(text)")
        guard let publisher = PYNetworkManager.shared.exec(request: request) else {
            return Empty<[PYSearchResult], Error>()
                .eraseToAnyPublisher()
        }
        return publisher
            .tryMap { data, response in
                do {
                    let decoder = JSONDecoder()
                    let decodedRespose = try decoder.decode(PYServerResponse<[PYSearchResult]>.self, from: data)
                    return decodedRespose.data ?? []
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}
