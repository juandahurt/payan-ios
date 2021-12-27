//
//  PlaceRouter.swift
//  Payan
//
//  Created by juandahurt on 15/11/21.
//

import Foundation
import UIKit

final class PlaceRouter: BaseRouter {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func show(using presenter: PlaceViewInput) {
        let vc = PlaceViewController(presenter: presenter)
        
        vc.modalPresentationStyle = .overCurrentContext
        
        navigationController.present(vc, animated: true)
    }
}
