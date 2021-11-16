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
    static func setup(with navigationController: UINavigationController, dataSource: PlaceModuleDataSource) -> PlaceViewController {
        let router = PlaceRouter(navigationController: navigationController)
        let presenter = PlacePresenter(place: dataSource.providePlace(), router: router)
        
        return PlaceViewController(presenter: presenter)
    }
}
