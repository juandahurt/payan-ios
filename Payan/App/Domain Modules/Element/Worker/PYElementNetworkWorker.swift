//
//  PYElementNetworkWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementNetworkWorker: PYElementDataAccessLogic {
    func getElementData(id: String, _ completion: @escaping (Result<PYElementPage, Error>) -> Void) {
        let request = PYNetworkRequest(endpoint: "element?id=\(id)")
        PYNetworkManager.shared.exec(request: request) { result in
            switch result {
            case .success(let data):
                let json = String(data: data, encoding: .utf8)
                print(json)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
