//
//  MainModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

final class MainModule {
    static func setup(with navigationController: UINavigationController) -> UIViewController {
        let router = MainRouter(navigationController: navigationController)
        let presenter = MainPresenter(router: router)
        let vc = MainViewController(presenter: presenter)
        let homeVC = HomeModule.setup(with: navigationController)
        
        homeVC.tabBarItem.title = "Inicio"
        homeVC.tabBarItem.image = UIImage(named: "home")?.withTintColor(Color.primary.withAlphaComponent(0.15))
        homeVC.tabBarItem.selectedImage = UIImage(named: "home")?.withTintColor(Color.primary).withRenderingMode(.alwaysOriginal)
        
        vc.viewControllers = [
            homeVC
        ]
        
        return vc
    }
}
