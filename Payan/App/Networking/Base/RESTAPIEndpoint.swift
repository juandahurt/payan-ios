//
//  HTTPEndpoint.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation
import Alamofire

struct RESTAPIEndpoint {
    var method: HTTPMethod
    var path: String
    
    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = RESTAPI.shared.baseUrl + path
    }
}
