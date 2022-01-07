//
//  MapModule.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import UIKit
import SwiftUI

class MapModule {
    var associatedViewController: UIViewController
    
    private init(navigationController: UINavigationController) {
        let interactor = MapInteractor(dataManager: RESTMapDataManager())
        let router = MapRouter(navigationController: navigationController)
        let presenter = MapPresenter(interactor: interactor, router: router)
        associatedViewController = UIHostingController(rootView: MapView(presenter: presenter))
        
        let title = "Mapa"
        let image = UIImage(named: "map")?.withTintColor(AppStyle.Color.primary.withAlphaComponent(0.15))
        let selectedImage = UIImage(named: "map")?.withTintColor(AppStyle.Color.primary).withRenderingMode(.alwaysOriginal)
        
        associatedViewController.tabBarItem.title = title
        associatedViewController.tabBarItem.image = image
        associatedViewController.tabBarItem.selectedImage = selectedImage
    }
    
    static func setup(with navigationController: UINavigationController) -> MapModule {
        MapModule(navigationController: navigationController)
    }
}
