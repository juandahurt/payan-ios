//
//  AppUpdateModule.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

protocol AppUpdateModuleDataSource {
    func latestVersionType() -> AppVersionType
}

protocol AppUpdateModuleDelegate {
    func didDismiss()
}

final class AppUpdateModule {
    static func setup(with navigationController: UINavigationController, dataSource: AppUpdateModuleDataSource, delegate: AppUpdateModuleDelegate?) -> UIViewController {
        let router = AppUpdateRouter(navigationController: navigationController)
        let presenter = AppUpdatePresenter(router: router, latestVersionType: dataSource.latestVersionType(), delegate: delegate)
        let bottomSheet = UIBottomSheet()
        let vc = AppUpdateViewController(presenter: presenter)
        
        bottomSheet.dataSource = vc
        bottomSheet.modalPresentationStyle = .overCurrentContext
        bottomSheet.modalTransitionStyle = .crossDissolve
        
        return bottomSheet
    }
}
