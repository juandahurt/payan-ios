//
//  AuthService.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import Foundation

protocol AnyAuthService {
    func login()
}

class RemoteAuthService: AnyAuthService {
    func login() {
        // Call the API.
    }
}
