//
//  MainPresenter.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation

protocol MainViewOutput {
    func shouldSelectTab(at index: Int) -> Bool
}

class MainPresenter: BasePresenter {
    var router: MainRouter
    
    init(router: MainRouter) {
        self.router = router
    }
}

extension MainPresenter: MainViewOutput {
    func shouldSelectTab(at index: Int) -> Bool {
        Console.log("before user selects tab at index \(index)", level: .event)
        return true
    }
}
