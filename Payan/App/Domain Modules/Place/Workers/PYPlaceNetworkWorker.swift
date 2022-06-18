//
//  PYPlaceNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation

class PYPlaceNetworkWorker: PYPlaceDataAccessLogic {
    func fecthPlace(id: String, completion: @escaping (Result<PYPlace, Error>) -> Void) {
        let request = PYNetworkRequest(endpoint: "place?id=\(id)")
        PYNetworkManager.shared.exec(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(PYServerResponse<PYPlace>.self, from: data)
                    if let place = decodedResponse.data {
                        completion(.success(place))
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
