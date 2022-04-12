//
//  PYCRouter.swift
//  Payan
//
//  Created by Juan Hurtado on 10/04/22.
//

import Foundation
import UIKit


class PYCRouter: PYCRoutingLogic {
    private let navigationController: UINavigationController
    weak var viewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show() {
        guard let viewController = viewController else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showPlace() {
        #warning("TODO: instance the place module")
        let vc = PYPViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
