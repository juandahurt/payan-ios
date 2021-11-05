//
//  AppUpdateRouter.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

final class AppUpdateRouter: BaseRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.showMainModule()
        }
    }
    
    private func showMainModule() {
        let vc = MainModule.setup(with: navigationController)
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        navigationController.present(vc, animated: true)
    }
}
