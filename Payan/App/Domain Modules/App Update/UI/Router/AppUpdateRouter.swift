//
//  AppUpdateRouter.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

protocol AnyAppUpdateRouter {
    func dismiss(completion: (() -> Void)?)
}

final class AppUpdateRouter: AnyAppUpdateRouter, BaseRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func dismiss(completion: (() -> Void)?) {
        navigationController.dismiss(animated: true) {
            completion?()
        }
    }
}
