//
//  ServerResponse.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct HTTPServerResponse<T: Decodable>: Decodable {
    var success: Bool
    var data: T?
    var error: HTTPServerError?
}

struct HTTPServerError: Error, Decodable {
    var id: String
    var description: String
}
