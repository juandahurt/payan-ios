//
//  HomeModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

final class HomeModule {
    let associatedViewController: UIViewController
    
    private init(navigationController: UINavigationController) {
        let interactor = HomeInteractor(dataManager: RESTHomeDataManager())
        let router = HomeRouter(navigationController: navigationController)
        let presenter = HomePresenter(interactor: interactor, router: router)
        associatedViewController = HomeViewController(presenter: presenter)
        
        let title = "Inicio"
        let image = UIImage(named: "home")?.withTintColor(AppStyle.Color.primary.withAlphaComponent(0.15))
        let selectedImage = UIImage(named: "home")?.withTintColor(AppStyle.Color.primary).withRenderingMode(.alwaysOriginal)
        
        associatedViewController.tabBarItem.title = title
        associatedViewController.tabBarItem.image = image
        associatedViewController.tabBarItem.selectedImage = selectedImage
    }
    
    static func setup(with navigationController: UINavigationController) -> HomeModule {
        HomeModule(navigationController: navigationController)
    }
}
