//
//  HomePresenter.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation

class HomePresenter: BasePresenter {
    var router: BaseRouter
    
    init(router: HomeRouter) {
        self.router = router
    }
}
