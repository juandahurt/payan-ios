//
//  PYServerResponse.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Foundation

struct PYServerResponse<T>: Decodable where T: Decodable {
    var success: Bool
    var data: T?
    var error: PYServerError?
}

struct PYServerError: Error, Decodable {
    var id: String
    var description: String
}
