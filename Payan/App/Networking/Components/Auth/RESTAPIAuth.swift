//
//  RESTAPIAuth.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct RESTAPIAuth {
    private static let path = "auth/"
    
    static let login = RESTAPIEndpoint(method: .post, path: "\(path)signIn")
}
