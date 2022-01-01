//
//  MapRouter.swift
//  Payan
//
//  Created by juandahurt on 1/01/22.
//

import Foundation
import UIKit

final class MapRouter: BaseRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showPlace(place: Place) {
        PlaceModule.setup(with: navigationController).show(place: place)
    }
}
