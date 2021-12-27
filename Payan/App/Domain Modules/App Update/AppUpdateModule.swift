//
//  AppUpdateModule.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

protocol AppUpdateModuleDataSource: AnyObject {
    func latestVersionType() -> AppVersionType
}

protocol AppUpdateModuleDelegate {
    func didDismiss()
}

final class AppUpdateModule {
    private let router: AppUpdateRouter
    private let presenter: AppUpdatePresenter
    
    private init(navigationController: UINavigationController, dataSource: AppUpdateModuleDataSource, delegate: AppUpdateModuleDelegate?) {
        router = AppUpdateRouter(navigationController: navigationController)
        presenter = AppUpdatePresenter(router: router, latestVersionType: dataSource.latestVersionType(), delegate: delegate)
    }
    
    static func setup(with navigationController: UINavigationController, dataSource: AppUpdateModuleDataSource, delegate: AppUpdateModuleDelegate?) -> AppUpdateModule {
        AppUpdateModule(navigationController: navigationController, dataSource: dataSource, delegate: delegate)
    }
    
    func show() {
        router.show(using: presenter)
    }
}
