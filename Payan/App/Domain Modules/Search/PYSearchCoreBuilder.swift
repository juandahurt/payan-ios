//
//  PYSearchCoreBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Foundation
import SwiftUI

class PYSearchCoreBuilder {
    func build(isVisible: Binding<Bool>) -> some View {
        let worker = PYSearchNetworkWorker()
        let interactor = PYSearchCoreInteractor(worker: worker)
        let viewModel = PYSearchCoreViewModel(interactor: interactor)
        return PYSearchCorePageView(isVisible: isVisible, viewModel: viewModel)
    }
}
