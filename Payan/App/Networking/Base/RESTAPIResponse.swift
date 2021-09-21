//
//  ServerResponse.swift
//  Payan
//
//  Created by juandahurt on 20/09/21.
//

import Foundation

struct RESTAPIResponse<T: Decodable>: Decodable {
    var success: Bool
    var data: T?
    var error: RESTAPIError?
}

struct RESTAPIError: Error, Decodable {
    var id: String
    var description: String
}
