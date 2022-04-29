//
//  PYFeedNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Foundation

class PYFeedNetworkWorker: PYFeedDataAccessLogic {
    func getData(completion: @escaping (Result<[PYFeedSection], Error>) -> Void) {
        let request = PYNetworkRequest(endpoint: "feed")
        PYNetworkManager.shared.exec(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(PYServerResponse<PYFeedPage>.self, from: data)
                    if let page = decodedResponse.data {
                        completion(.success(page.sections))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
