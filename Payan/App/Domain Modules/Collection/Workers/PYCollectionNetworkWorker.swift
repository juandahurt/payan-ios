//
//  PYCollectionNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation

class PYCollectionNetworkWorker: PYCollectionDataAccessLogic {
    func getCollection(ofType type: String, categoryId: String?, completion: @escaping (Result<PYCollection, Error>) -> Void) {
        let request = PYNetworkRequest(endpoint: "collection?type=\(type)&category_id=\(categoryId ?? "")")
        PYNetworkManager.shared.exec(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(PYServerResponse<PYCollection>.self, from: data)
                    if let collection = decodedResponse.data {
                        completion(.success(collection))
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
