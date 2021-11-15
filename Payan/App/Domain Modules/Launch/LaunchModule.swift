//
//  LaunchModule.swift
//  Payan
//
//  Created by juandahurt on 23/10/21.
//

import Foundation
import UIKit

final class LaunchModule {
    static func setup(with navigationController: UINavigationController) -> UIViewController {
        let router = LaunchRouter(navigationController: navigationController)
        let interactor = LaunchInteractor(dataManager: LaunchDataManager())
        let presenter = LaunchPresenter(interactor: interactor, router: router)
        
        return LaunchViewController(presenter: presenter)
    }
}
