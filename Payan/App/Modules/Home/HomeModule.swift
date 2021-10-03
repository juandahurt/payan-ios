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
        // TODO: Pass the presenter to the view controller
        let router = HomeRouter(navigationController: navigationController)
        _ = HomePresenter(router: router)
        return HomeViewController()
    }
}
