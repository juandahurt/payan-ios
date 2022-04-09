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
    
    private init(navigationController: UINavigationController) {
        let presenter = PYHPresenter()
        let interactor = PYHInteractor(presenter: presenter)
        let router = PYHRouter(navigationController: navigationController)
        associatedViewController = PYHViewController(interactor: interactor, router: router)
        presenter.view = associatedViewController as? PYHViewLogic
        
        let title = "Inicio"
        let image = UIImage(named: "home")?.withTintColor(AppStyle.Color.G7)
        let selectedImage = UIImage(named: "home")?.withTintColor(AppStyle.Color.G2).withRenderingMode(.alwaysOriginal)
        
        associatedViewController.tabBarItem.title = title
        associatedViewController.tabBarItem.image = image
        associatedViewController.tabBarItem.selectedImage = selectedImage
    }
    
    static func setup(with navigationController: UINavigationController) -> PYHomeModule {
        PYHomeModule(navigationController: navigationController)
    }
}
