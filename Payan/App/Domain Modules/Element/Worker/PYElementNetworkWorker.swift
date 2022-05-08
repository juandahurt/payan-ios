//
//  PYElementNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementNetworkWorker: PYElementDataAccessLogic {
    func getElementData(id: String, _ completion: @escaping (Result<[PYElementSection], Error>) -> Void) {
        let request = PYNetworkRequest(endpoint: "element?id=\(id)")
        PYNetworkManager.shared.exec(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(PYServerResponse<PYElementPage>.self, from: data)
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
