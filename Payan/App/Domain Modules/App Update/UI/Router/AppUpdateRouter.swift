//
//  AppUpdateRouter.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

protocol AnyAppUpdateRouter {
    func show(using presenter: AppUpdateViewInput & AppUpdateViewOutput)
    func dismiss(completion: (() -> Void)?)
}

final class AppUpdateRouter: AnyAppUpdateRouter, BaseRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show(using presenter: AppUpdateViewInput & AppUpdateViewOutput) {
        let vc = AppUpdateViewController(presenter: presenter)
        let bottomSheet = UIBottomSheet()
        
        bottomSheet.dataSource = vc
        bottomSheet.modalTransitionStyle = .crossDissolve
        bottomSheet.modalPresentationStyle = .overCurrentContext
        
        navigationController.present(bottomSheet, animated: true)
    }
    
    func dismiss(completion: (() -> Void)?) {
        navigationController.dismiss(animated: true) {
            completion?()
        }
    }
}
