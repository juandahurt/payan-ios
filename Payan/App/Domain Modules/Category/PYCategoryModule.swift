//
//  PYCategoryModule.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation
import UIKit


final class PYCateogryModule {
    private let view: PYCViewLogic
    private var router: PYCRoutingLogic
    
    private init(navigationController: UINavigationController) {
        let presenter = PYCPresenter()
        let interactor = PYCInteractor(presenter: presenter)
        view = PYCViewController(interactor: interactor)
        router = PYCRouter(navigationController: navigationController)
        router.viewController = view as? UIViewController
        presenter.view = view
    }
    
    static func setup(with navigationController: UINavigationController) -> PYCateogryModule {
        PYCateogryModule(navigationController: navigationController)
    }
    
    func show() {
        router.show()
    }
}
