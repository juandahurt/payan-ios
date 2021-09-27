//
//  RESTAPIAuth.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct HTTPAuthEndpoint {
    private static let path = "auth/"
    
    static let login = HTTPEndpoint(method: .post, path: "\(path)signIn")
}
