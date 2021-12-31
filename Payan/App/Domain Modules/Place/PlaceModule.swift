//
//  PlaceModule.swift
//  Payan
//
//  Created by juandahurt on 15/11/21.
//

import Foundation
import UIKit

protocol PlaceModuleDataSource {
    func providePlace() -> Place
}

final class PlaceModule {
    private let router: PlaceRouter
    var dataSource: PlaceModuleDataSource?
    
    private init(navigationController: UINavigationController) {
        router = PlaceRouter(navigationController: navigationController)
    }
    
    static func setup(with navigationController: UINavigationController) -> PlaceModule {
        PlaceModule(navigationController: navigationController)
    }
    
    func show() {
        guard let dataSource = dataSource else {
            return
        }
        
        let interactor = PlaceInteractor()
        let presenter = PlacePresenter(place: dataSource.providePlace(), router: router, interactor: interactor)
        router.show(using: presenter)
    }
}
