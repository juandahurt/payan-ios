//
//  PYNetworkManager.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Combine
import Foundation
import UIKit

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
        var urlRequest = URLRequest(url: url)
        addHeaders(to: &urlRequest)
        
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
        guard let stringUrl = "\(baseUrl)/\(request.endpoint)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        guard let url = URL(string: stringUrl) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        addHeaders(to: &urlRequest)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
    }
}

extension PYNetworkManager {
    func addHeaders(to request: inout URLRequest) {
        request.addValue(UIDevice.current.systemName, forHTTPHeaderField: "X-Platform")
        request.addValue(UIDevice.current.systemVersion, forHTTPHeaderField: "X-Platform-Version")
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        request.addValue(appVersion, forHTTPHeaderField: "X-App-Version")
    }
}
