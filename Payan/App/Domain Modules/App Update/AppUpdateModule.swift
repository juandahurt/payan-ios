//
//  AppUpdateModule.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

final class AppUpdateModule: BaseModule {
    static func setup(with navigationController: UINavigationController) -> UIViewController {
        let router = AppUpdateRouter(navigationController: navigationController)
        let presenter = AppUpdatePresenter(router: router)
        let bottomSheet = UIBottomSheet()
        let vc = AppUpdateViewController(presenter: presenter)
        
        bottomSheet.dataSource = vc
        bottomSheet.modalPresentationStyle = .overCurrentContext
        bottomSheet.modalTransitionStyle = .crossDissolve
        
        return bottomSheet
    }
}
