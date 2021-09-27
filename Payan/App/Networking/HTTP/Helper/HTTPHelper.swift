//
//  HTTPHelper.swift
//  Payan
//
//  Created by juandahurt on 26/09/21.
//

import Foundation
import RxSwift

struct HTTPHelper {
    static func createRequest<D: Encodable>(using endpoint: HTTPEndpoint, data: D? = nil) -> URLRequest? {
        guard let url = URL(string: endpoint.path) else {
            Console.log("url '\(endpoint.path)' is malformed", level: .error)
            return nil
        }
        
        var request = URLRequest(url: url)
        if let httpBody = try? JSONEncoder().encode(data) {
            request.httpBody = httpBody
        }
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = endpoint.method.rawValue
        
        return request
    }
    
    static func createRequest(using endpoint: HTTPEndpoint) -> URLRequest? {
        guard let url = URL(string: endpoint.path) else {
            Console.log("url \(endpoint.path) is malformed", level: .error)
            return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = endpoint.method.rawValue
        
        return request
    }
}
