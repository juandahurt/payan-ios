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
    
    func show(presenter: LaunchViewOutput) {
        let vc = LaunchViewController(presenter: presenter)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showMainModule() {
        MainModule.setup(with: navigationController).show()
    }
    
    func showAppUpdateModule(dataSource: AppUpdateModuleDataSource, delegate: AppUpdateModuleDelegate) {
        let vc = AppUpdateModule.setup(with: navigationController, dataSource: dataSource, delegate: delegate)
        
        navigationController.present(vc, animated: true)
    }
}
