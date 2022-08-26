//
//  PYCollectionNeworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Combine
import Foundation

class PYCollectionNetworkWorker: PYCollectionDataAccessLogic {
    func getCollection(type: String, categoryId: String?) -> AnyPublisher<PYCollection, Error> {
        let request = PYNetworkRequest(endpoint: "collection?type=\(type)&category_id=\(categoryId ?? "")")
        guard let publisher = PYNetworkManager.shared.exec(request: request) else {
            return Empty<PYCollection, Error>()
                .eraseToAnyPublisher()
        }
        return publisher
            .tryMap { data, response in
                do {
                    let decoder = JSONDecoder()
                    let decodedRespose = try decoder.decode(PYServerResponse<PYCollection>.self, from: data)
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
