//
//  HomeModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

final class PYHomeModule {
    let associatedViewController: UIViewController
    var router: PYHRoutingLogic
    
    private init(navigationController: UINavigationController) {
        let presenter = PYHPresenter()
        let interactor = PYHInteractor(presenter: presenter, worker: PYHNetworkWorker())
        router = PYHRouter(navigationController: navigationController)
        associatedViewController = PYHViewController(interactor: interactor, router: router)
        presenter.view = associatedViewController as? PYHViewLogic
        router.viewController = associatedViewController
    }
    
    static func setup(with navigationController: UINavigationController) -> PYHomeModule {
        PYHomeModule(navigationController: navigationController)
    }
    
    func show() {
        router.show()
    }
}
