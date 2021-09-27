//
//  LoginModule.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import UIKit

final class LoginModule {
    private var router: AnyLoginRouter
    private var presenter: AnyLoginPresenter
    
    init(navigationController: UINavigationController) {
        router = LoginRouter(navigationController: navigationController)
        let service = RESTAPIAuthService()
        let interactor = LoginInteractor(authService: service)
        presenter = LoginPresenter(interactor: interactor)
    }
    
    func show() {
        router.show(using: presenter)
    }
}
