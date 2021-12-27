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
    private let presenter: PlacePresenter
    
    private init(navigationController: UINavigationController, dataSource: PlaceModuleDataSource) {
        router = PlaceRouter(navigationController: navigationController)
        presenter = PlacePresenter(place: dataSource.providePlace(), router: router)
    }
    
    static func setup(with navigationController: UINavigationController, dataSource: PlaceModuleDataSource) -> PlaceModule {
        PlaceModule(navigationController: navigationController, dataSource: dataSource)
    }
    
    func show() {
        router.show(using: presenter)
    }
}
