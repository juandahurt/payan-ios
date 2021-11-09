//
//  HomeModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

class HomeModule: BaseModule {
    static func setup(with navigationController: UINavigationController) -> UIViewController {
        let router = HomeRouter(navigationController: navigationController)
        let interactor = HomeInteractor(dataManager: RESTHomeDataManager())
        let presenter = HomePresenter(interactor: interactor, router: router)
        return HomeViewController(presenter: presenter)
    }
}
