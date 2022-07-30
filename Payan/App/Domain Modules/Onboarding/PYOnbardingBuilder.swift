//
//  PYOnbardingBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 30/07/22.
//

import Foundation
import UIKit
import SwiftUI

class PYOnbardingBuilder {
    func build(continueOnTap: @escaping () -> Void) -> UIViewController {
        let worker = PYOnboardingLocalWorker()
        let interactor = PYOnbardingInteractor(worker: worker)
        let viewModel = PYOnboardingViewModel(interactor: interactor)
        let view = PYOnboardingPageView(viewModel: viewModel, continueOnTap: continueOnTap)
        return UIHostingController(rootView: view)
    }
}
