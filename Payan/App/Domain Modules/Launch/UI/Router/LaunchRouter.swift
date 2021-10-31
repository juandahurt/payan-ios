//
//  LaunchRouter.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation
import UIKit

final class LaunchRouter: BaseRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showMainModule() {
        let vc = MainModule.setup(with: navigationController)
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        navigationController.present(vc, animated: true)
    }
    
    func showAppNeedsUpdate() {
        let vc = AppUpdateViewController()
        let bottomSheet = UIBottomSheet(embededView: vc.view)
        
        bottomSheet.modalPresentationStyle = .overCurrentContext
        bottomSheet.modalTransitionStyle = .crossDissolve
        
        navigationController.present(bottomSheet, animated: true)
    }
}
