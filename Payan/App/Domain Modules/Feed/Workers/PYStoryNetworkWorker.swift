//
//  PYStoryNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 20/07/22.
//

import Combine
import Foundation

class PYStoryNetworkWorker: PYStoryDataAccessLogic {
    func getStory(id: String) -> AnyPublisher<PYStoryData, Error> {
        let request = PYNetworkRequest(endpoint: "story?id=\(id)")
        guard let publisher = PYNetworkManager.shared.exec(request: request) else {
            return Empty<PYStoryData, Error>()
                .eraseToAnyPublisher()
        }
        return publisher
            .tryMap { data, response in
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(PYServerResponse<PYStoryData>.self, from: data)
                    return decodedResponse.data!
                } catch {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}
