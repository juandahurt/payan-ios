//
//  PYHRouter.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation
import UIKit


class PYHRouter: PYHRoutingLogic {
    var navigationController: UINavigationController
    weak var viewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showCategory() {
        let module = PYCateogryModule.setup(with: navigationController)
        module.show()
    }
    
    func show() {
        guard let viewController = viewController else { return }
        navigationController.pushViewController(viewController, animated: true)
    }
}
