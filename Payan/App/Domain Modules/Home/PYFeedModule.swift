//
//  PYFeedModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

final class PYFeedModule {
    let associatedViewController: UIViewController
    var router: PYFeedRoutingLogic
    
    private init(navigationController: UINavigationController) {
        let presenter = PYFeedPresenter()
        let interactor = PYFeedInteractor(presenter: presenter, worker: PYFeedNetworkWorker())
        router = PYFeedRouter(navigationController: navigationController)
        associatedViewController = PYFeedViewController(interactor: interactor, router: router)
        presenter.view = associatedViewController as? PYFeedViewLogic
        router.viewController = associatedViewController
    }
    
    static func setup(with navigationController: UINavigationController) -> PYFeedModule {
        PYFeedModule(navigationController: navigationController)
    }
    
    func show() {
        router.show()
    }
}
