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

final class RESTAPIAuthService: AnyAuthService {
    
    func login(with credential: Credential) -> Single<String> {
        let endpoint = HTTPAuthEndpoint.login
        let url = URL(string: endpoint.path)!
        var request = URLRequest(url: url)
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = try! JSONEncoder().encode(credential)
        Console.log("app is about to call: \(endpoint.path)", level: .network)
        
        return Single.create { single in
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
            return Disposables.create()
        }
    }
}
