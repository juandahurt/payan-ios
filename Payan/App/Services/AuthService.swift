//
//  AuthService.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import Foundation
import RxSwift

protocol AnyAuthService {
    func login(with credential: Credential) -> Single<String>
}

final class HTTPAuthService: AnyAuthService {
    func login(with credential: Credential) -> Single<String> {
        Single.create { single in
            let endpoint = HTTPAuthEndpoint.login
            if let request = HTTPHelper.createRequest(using: endpoint, data: credential) {
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        Console.log("\(error)", level: .error)
                        single(.failure(error))
                    }
                    if let data = data {
                        do {
                            let decodedBody = try JSONDecoder().decode(HTTPServerResponse<String>.self, from: data)
                            Console.log("decoded server response: \(decodedBody)", level: .network)
                            if decodedBody.success {
                                single(.success(decodedBody.data!))
                            } else {
                                single(.failure(decodedBody.error!))
                            }
                        } catch {
                            Console.log("\(error)", level: .error)
                            single(.failure(error))
                        }
                    }
                }.resume()
            } else {
                single(.failure(HTTPError.malformedUrl))
            }
            return Disposables.create()
        }
    }
}
