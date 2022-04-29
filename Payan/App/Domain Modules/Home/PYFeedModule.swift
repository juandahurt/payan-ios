//
//  PYFeedModule.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

final class PYFeedModule: PYModule {
    var host: String = "feed"
    
    func getViewController(params: [URLQueryItem]) -> UIViewController? {
        let presenter = PYFeedPresenter()
        let interactor = PYFeedInteractor(presenter: presenter, worker: PYFeedNetworkWorker())
        let vc = PYFeedViewController(interactor: interactor)
        presenter.view = vc
        return vc
    }
}
