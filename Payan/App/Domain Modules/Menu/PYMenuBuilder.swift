//
//  PYMenuBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation

final class PYMenuBuilder {
    func buildModule() -> PYMenuPageView {
        let worker = PYMenuLocalWorker()
        let interactor = PYMenuInteractor(worker: worker)
        let viewModel = PYMenuViewModel(interactor: interactor)
        return PYMenuPageView(viewModel: viewModel)
    }
}
