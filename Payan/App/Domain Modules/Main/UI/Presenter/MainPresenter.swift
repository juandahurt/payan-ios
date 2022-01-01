//
//  MainPresenter.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation

class MainPresenter: BasePresenter {
    var router: MainRouter
    
    init(router: MainRouter) {
        self.router = router
    }
}
