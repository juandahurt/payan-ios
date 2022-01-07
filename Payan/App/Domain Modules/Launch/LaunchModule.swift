//
//  LaunchModule.swift
//  Payan
//
//  Created by juandahurt on 23/10/21.
//

import Foundation
import UIKit

final class LaunchModule {
    private let presenter: LaunchPresenter
    private let router: LaunchRouter
    
    private init(navigationController: UINavigationController) {
        router = LaunchRouter(navigationController: navigationController)
        let interactor = LaunchInteractor(dataManager: LaunchDataManager())
        presenter = LaunchPresenter(interactor: interactor, router: router)
    }
    
    static func setup(with navigationController: UINavigationController) -> LaunchModule {
        LaunchModule(navigationController: navigationController)
    }
    
    func show() {
        router.show(presenter: presenter)
    }
}
