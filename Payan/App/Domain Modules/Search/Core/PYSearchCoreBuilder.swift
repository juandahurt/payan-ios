//
//  PYSearchCoreBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Foundation
import SwiftUI

class PYSearchCoreBuilder: PYModuleBuilder {
    func build(params: [URLQueryItem]) -> UIViewController? {
        let worker = PYSearchCoreMockWorker()
        let interactor = PYSearchCoreInteractor(worker: worker)
        let viewModel = PYSearchCoreViewModel(interactor: interactor)
        let view = PYSearchCorePageView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
