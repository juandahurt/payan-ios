//
//  RESTClient.swift
//  Payan
//
//  Created by juandahurt on 22/10/21.
//

import Foundation

struct RESTClient {
    private static var _shared: RESTClient?
    static var shared: RESTClient {
        get {
            if _shared == nil {
                fatalError("You must provide a base url! Use the `provideBaseUrl()` function")
            }
            return _shared!
        }
    }
    private var baseUrl: String
    
    static func provideBaseUrl(_ url: String) {
        _shared = RESTClient(baseUrl: url)
    }
}

import RxSwift

extension RESTClient {
    func call<B: Encodable, R: Decodable>(endpoint: RESTEnpoint<B>) -> Single<RESTServerResponse<R>> {
        return Single.create { single in
            let disposable = Disposables.create()
            guard let request = createRequest(using: endpoint) else {
                single(.failure(RESTError.urlMalformed))
                return disposable
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(RESTServerResponse<R>.self, from: data) {
                        if let serverError = decodedResponse.error {
                            single(.failure(serverError))
                        } else {
                            single(.success(decodedResponse))
                        }
                    } else {
                        single(.failure(RESTError.unableToDecodeResponse))
                    }
                }
            }.resume()
            
            return disposable
        }
    }
    
    private func createRequest<D: Encodable>(using endpoint: RESTEnpoint<D>) -> URLRequest? {
        guard let url = URL(string: baseUrl + endpoint.path) else {
            return nil
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.method.rawValue
        if let data = endpoint.body {
            let encodedData = try? JSONEncoder().encode(data)
            request.httpBody = encodedData
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
