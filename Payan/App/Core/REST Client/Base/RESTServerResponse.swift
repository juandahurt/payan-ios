//
//  RESTResponse.swift
//  Payan
//
//  Created by juandahurt on 22/10/21.
//

import Foundation

struct RESTServerResponse<T>: Decodable where T: Decodable {
    var success: Bool
    var data: T?
    var error: RESTServerError?
}

struct RESTServerError: Error, Decodable {
    var id: String
    var description: String
}
