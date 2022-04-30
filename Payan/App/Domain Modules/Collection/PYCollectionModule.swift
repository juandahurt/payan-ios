//
//  PYCollectionModule.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation
import UIKit


final class PYCollectionModule: PYModule {
    var host: String = "collection"
    
    func getViewController(params: [URLQueryItem]) -> UIViewController? {
        guard params.count == 1, params[0].name == "type", let typeId = params[0].value else { return nil }
        let presenter = PYCollectionPresenter()
        let interactor = PYCollectionInteractor(presenter: presenter)
        let vc = PYCollectionViewController(interactor: interactor)
        vc.typeId = typeId
        presenter.view = vc
        return vc
    }
}
