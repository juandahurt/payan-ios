//
//  PYMapWebRepository.swift
//  Payan
//
//  Created by Juan Hurtado on 30/10/22.
//

import Combine
import Foundation

final class PYMapWebRepository: PYMapDataAccessLogic {
    func getPlacesLocations() -> AnyPublisher<[PYPlaceLocation], Error> {
        let request = PYNetworkRequest(endpoint: "place/locations")
        guard let publisher = PYNetworkManager.shared.exec(request: request) else {
            return Empty<[PYPlaceLocation], Error>()
                .eraseToAnyPublisher()
        }
        return publisher
            .tryMap { data, response in
                do {
                    let decoder = JSONDecoder()
                    let decodedRespose = try decoder.decode(PYServerResponse<[PYPlaceLocation]>.self, from: data)
                    if let data = decodedRespose.data {
                        return data
                    }
                    throw PYNetworkError.unknown
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}
