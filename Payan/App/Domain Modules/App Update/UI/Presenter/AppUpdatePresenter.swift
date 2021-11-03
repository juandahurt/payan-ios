//
//  AppUpdatePresenter.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation

protocol AppUpdateViewOutput {
    func dismissUpdate()
}

final class AppUpdatePresenter: BasePresenter {
    var router: BaseRouter
    
    init(router: AppUpdateRouter) {
        self.router = router
    }
}

extension AppUpdatePresenter: AppUpdateViewOutput {
    func dismissUpdate() {
        (router as! AppUpdateRouter).dismiss()
    }
}
