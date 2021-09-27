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
            _shared = HTTPServer()
        }
        return _shared!
    }
    
    var baseUrl: String {
        switch AppConfig.environment {
        case .dev:
            return "https://payan-dev.herokuapp.com/"
        }
    }
}
