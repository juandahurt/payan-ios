//
//  PYNetworkManager.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Combine
import Foundation

final class PYNetworkManager {
    private static var _shared: PYNetworkManager?
    static var shared: PYNetworkManager {
        get {
            if _shared == nil {
                fatalError("You must provide a base url. Use the provideBaseUrl function.")
            }
            return _shared!
        }
    }
    
    var baseUrl: String
    
    private init(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    static func provideBaseUrl(_ baseUrl: String) {
        _shared = PYNetworkManager(baseUrl)
    }
}


extension PYNetworkManager {
    func exec(request: PYNetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let stringUrl = "\(baseUrl)/\(request.endpoint)"
        guard let url = URL(string: stringUrl) else {
            completion(.failure(PYNetworkError.malformedUrl))
            return
        }
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
    
    func exec(request: PYNetworkRequest) -> URLSession.DataTaskPublisher {
        let stringUrl = "\(baseUrl)/\(request.endpoint)"
        let url = URL(string: stringUrl)!

        return URLSession.shared.dataTaskPublisher(for: url)
    }
}
