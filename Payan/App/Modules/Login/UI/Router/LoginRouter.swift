//
//  LoginRouter.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import UIKit

protocol AnyLoginRouter {
    var navigationController: UINavigationController { get set }
    func show(presenter: AnyLoginPresenter)
}

final class LoginRouter: AnyLoginRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show(presenter: AnyLoginPresenter) {
        let vc = LoginViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
