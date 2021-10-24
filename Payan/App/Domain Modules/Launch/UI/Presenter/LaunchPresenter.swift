//
//  LaunchPresenter.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation

protocol LaunchViewOutput {
    func showHomeModule()
}

final class LaunchPresenter: BasePresenter {
    var router: BaseRouter
    
    init(router: LaunchRouter) {
        self.router = router
    }
}

extension LaunchPresenter: LaunchViewOutput {
    func showHomeModule() {
        (router as! LaunchRouter).showMainModule()
    }
}
