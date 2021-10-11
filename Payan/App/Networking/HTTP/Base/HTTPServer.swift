//
//  HTTPNetwork.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct HTTPServer {
    private static var _shared: HTTPServer?
    static var shared: HTTPServer {
        if _shared == nil {
            Console.log("you have not provided a base url!", level: .error)
            fatalError()
        }
        return _shared!
    }
    
    var baseUrl: String
    
    static func provideBaseUrl(_ url: String) {
        _shared = HTTPServer(baseUrl: url)
    }
}
