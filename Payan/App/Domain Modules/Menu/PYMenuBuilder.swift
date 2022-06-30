//
//  PYMenuBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation
import UIKit
import SwiftUI

final class PYMenuBuilder {
    func getViewController() -> UIViewController {
        let worker = PYMenuLocalWorker()
        let interactor = PYMenuInteractor(worker: worker)
        let viewModel = PYMenuViewModel(interactor: interactor)
        let vc = UIHostingController(rootView: PYMenuPageView(viewModel: viewModel))
        return vc
    }
}
