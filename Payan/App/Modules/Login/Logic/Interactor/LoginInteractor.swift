//
//  LoginInteractor.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import RxSwift

protocol AnyLoginInteractor {
    var authService: AnyAuthService { get set }
    
    func login() -> Single<Void>
}

final class LoginInteractor: AnyLoginInteractor {
    var authService: AnyAuthService
    
    init(authService: AnyAuthService) {
        self.authService = authService
    }
    
    func login() -> Single<Void> {
        authService.login()
    }
}
