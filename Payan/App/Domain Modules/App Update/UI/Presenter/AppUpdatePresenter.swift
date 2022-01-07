//
//  AppUpdatePresenter.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

protocol AppUpdateViewInput {
    var versionType: AppVersionType { get }
}

protocol AppUpdateViewOutput {
    func dismissUpdate()
    func update()
}

final class AppUpdatePresenter: BasePresenter {
    var router: AppUpdateRouter
    internal var latestVerionType: AppVersionType
    internal var delegate: AppUpdateModuleDelegate?
    
    init(router: AppUpdateRouter, latestVersionType: AppVersionType, delegate: AppUpdateModuleDelegate?) {
        self.router = router
        self.latestVerionType = latestVersionType
        self.delegate = delegate
    }
}

extension AppUpdatePresenter: AppUpdateViewInput {
    var versionType: AppVersionType {
        latestVerionType
    }
}

extension AppUpdatePresenter: AppUpdateViewOutput {
    func update() {
        // TODO: Open appstore url!
    }
    
    func dismissUpdate() {
        router.dismiss { [weak self] in
            self?.delegate?.didDismiss()
        }
    }
}
