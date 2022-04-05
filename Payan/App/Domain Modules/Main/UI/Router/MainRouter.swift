//
//  MainRuoter.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

final class MainRouter: BaseRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show(using presenter: MainPresenter) {
        let vc = MainViewController()
        
        vc.viewControllers = [
            PYHomeModule.setup(with: navigationController).associatedViewController
        ]
        
        navigationController.pushViewController(vc, animated: true)
        navigationController.viewControllers = [vc]
    }
}
