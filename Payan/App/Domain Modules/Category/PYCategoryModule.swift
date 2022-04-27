//
//  PYCategoryModule.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation
import UIKit


final class PYCateogryModule: PYModule {
    var route: String = "collection"
    var navigationController: UINavigationController
    
    private let view: PYCViewLogic
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        let presenter = PYCPresenter()
        let interactor = PYCInteractor(presenter: presenter)
        view = PYCViewController(interactor: interactor)
        presenter.view = view
    }
    
    func open(params: [URLQueryItem]) {
        guard params.count == 1, params[0].name == "type", let typeId = params[0].value else { return }
        guard let vc = view as? UIViewController else { return }
        view.typeId = typeId
        navigationController.pushViewController(vc, animated: true)
    }
}
