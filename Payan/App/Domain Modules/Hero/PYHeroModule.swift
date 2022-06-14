//
//  PYHeroModule.swift
//  Payan
//
//  Created by Juan Hurtado on 13/06/22.
//

import Foundation
import UIKit
import SwiftUI

final class PYHeroModule: PYModule {
    var host: String = "hero"
    
    func getViewController(params: [URLQueryItem]) -> UIViewController? {
        guard !params.isEmpty, params[0].name == "id", let heroId = params[0].value else { return nil }
        let worker = PYHeroNetworkWorker()
        let interactor = PYHeroInteractor(worker: worker)
        let viewModel = PYHeroViewModel(interactor: interactor)
        let view = PYHeroPageView(heroId: heroId, viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
