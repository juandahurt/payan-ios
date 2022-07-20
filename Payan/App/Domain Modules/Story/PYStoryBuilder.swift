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
        let worker = PYStoryNetworkWorker()
        let interactor = PYStoryInteractor(worker: worker)
        let viewModel = PYStoryViewModel(interactor: interactor)
        let view = PYStoryPageView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
