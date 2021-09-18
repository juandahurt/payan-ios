//
//  LoginInteractor.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation

protocol AnyLoginInteractor {
    var authService: AnyAuthService { get set }
    
    func login()
}

final class LoginInteractor: AnyLoginInteractor {
    var authService: AnyAuthService
    
    init(authService: AnyAuthService) {
        self.authService = authService
    }
    
    func login() {
        authService.login()
    }
}
