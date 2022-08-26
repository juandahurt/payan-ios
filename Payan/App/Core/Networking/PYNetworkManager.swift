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
        guard let stringUrl = "\(baseUrl)/\(request.endpoint)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(PYNetworkError.malformedUrl))
            return
        }
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
    
    func exec(request: PYNetworkRequest) -> URLSession.DataTaskPublisher? {
        guard let stringUrl = "\(baseUrl)/\(request.endpoint)".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) else {
            return nil
        }
        guard let url = URL(string: stringUrl) else {
            return nil
        }

        return URLSession.shared.dataTaskPublisher(for: url)
    }
}
