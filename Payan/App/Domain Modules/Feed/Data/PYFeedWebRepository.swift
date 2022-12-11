//
//  PYFeedWebRepository.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 8/12/22.
//

import Combine
import Foundation

class PYFeedWebRepository: PYFeedDataAccessLogic {
    func getData() -> AnyPublisher<PYFeedPageData, Error> {
        let request = PYNetworkRequest(endpoint: "feed")
        guard let publisher = PYNetworkManager.shared.exec(request: request) else {
            return Empty<PYFeedPageData, Error>()
                .eraseToAnyPublisher()
        }
        return publisher
            .tryMap { data, response in
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(PYServerResponse<PYFeedPageData>.self, from: data)
                    if let data = decodedResponse.data {
                        return data
                    }
                    throw PYNetworkError.unknown
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getStory(identifiedBy id: String) -> AnyPublisher<PYStoryData, Error> {
        let request = PYNetworkRequest(endpoint: "story?id=\(id)")
        guard let publisher = PYNetworkManager.shared.exec(request: request) else {
            return Empty<PYStoryData, Error>()
                .eraseToAnyPublisher()
        }
        return publisher
            .tryMap { data, response in
                do {
                    let decoder = JSONDecoder()
                    let decodedRespose = try decoder.decode(PYServerResponse<PYStoryData>.self, from: data)
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
