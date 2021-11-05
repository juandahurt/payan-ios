//
//  AppUpdatePresenter.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

protocol AppUpdateViewOutput {
    func dismissUpdate()
    func update()
}

final class AppUpdatePresenter: BasePresenter {
    var router: BaseRouter
    
    init(router: AppUpdateRouter) {
        self.router = router
    }
}

extension AppUpdatePresenter: AppUpdateViewOutput {
    func update() {
        // TODO: Open appstore url!
    }
    
    func dismissUpdate() {
        (router as! AppUpdateRouter).dismiss()
    }
}
