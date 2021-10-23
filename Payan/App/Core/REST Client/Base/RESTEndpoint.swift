//
//  RESTEndpoint.swift
//  Payan
//
//  Created by juandahurt on 22/10/21.
//

import Foundation

struct RESTEnpoint<T> where T: Encodable {
    var path: String
    var method: RESTMethod
    var data: T?
}
