//
//  PYStoryBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 20/07/22.
//

import Foundation
import SwiftUI

class PYStoryBuilder: PYModuleBuilder {
    func build(params: [URLQueryItem]) -> UIViewController? {
        guard params.count == 1, params[0].name == "id", let id = params[0].value else { return nil }
        let worker = PYStoryNetworkWorker()
        let interactor = PYStoryInteractor(worker: worker)
        let viewModel = PYStoryViewModel(interactor: interactor)
        let view = PYStoryPageView(id: id, viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
