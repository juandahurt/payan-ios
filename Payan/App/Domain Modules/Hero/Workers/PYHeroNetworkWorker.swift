//
//  PYHeroNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 14/06/22.
//

import Foundation

class PYHeroNetworkWorker: PYHeroDataAccessLogic {
    func fetchHero(identifiedBy id: String, completion: @escaping (Result<PYHero, Error>) -> Void) {
        let request = PYNetworkRequest(endpoint: "hero?id=\(id)")
        PYNetworkManager.shared.exec(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(PYServerResponse<PYHero>.self, from: data)
                    if let hero = decodedResponse.data {
                        completion(.success(hero))
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
