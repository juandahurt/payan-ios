//
//  LoginModule.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import UIKit

final class LoginModule: BaseModule {
    static func setup(with navigationController: UINavigationController) -> UIViewController {
        let interactor = LoginInteractor(authService: RESTAPIAuthService())
        let router = LoginRouter(navigationController: navigationController)
        let presenter = LoginPresenter(interactor: interactor, router: router)
        return LoginViewController(presenter: presenter)
    }
}
