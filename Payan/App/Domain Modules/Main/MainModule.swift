//
//  MainModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

final class MainModule {
    private let presenter: MainPresenter
    private let router: MainRouter
    
    private init(navigationController: UINavigationController) {
        router = MainRouter(navigationController: navigationController)
        presenter = MainPresenter(router: router)
    }
    
    static func setup(with navigationController: UINavigationController) -> MainModule {
        MainModule(navigationController: navigationController)
    }
    
    func show() {
        router.show(using: presenter)
    }
}
