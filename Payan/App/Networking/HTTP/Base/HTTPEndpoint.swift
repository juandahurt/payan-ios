//
//  HTTPEndpoint.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct HTTPEndpoint {
    var method: HTTPMethod
    var path: String
    
    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = HTTPServer.shared.baseUrl + path
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
