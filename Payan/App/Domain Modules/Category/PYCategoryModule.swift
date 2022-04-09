//
//  PYCategoryModule.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation
import UIKit


final class PYCateogryModule {
    let associatedViewController: UIViewController
    
    private init(navigationController: UINavigationController) {
        let presenter = PYCPresenter()
        let interactor = PYCInteractor(presenter: presenter)
        associatedViewController = PYCViewController(interactor: interactor)
        presenter.view = associatedViewController as? PYCViewLogic
    }
    
    static func setup(with navigationController: UINavigationController) -> PYCateogryModule {
        PYCateogryModule(navigationController: navigationController)
    }
}
