//
//  PYMainModule.swift
//  Payan
//
//  Created by Juan Hurtado on 18/06/22.
//

import Foundation
import UIKit
import SwiftUI

final class PYMainModule {
    static func getViewController() -> UIViewController {
        let worker = PYMainLocalWorker()
        let interactor = PYMainInteractor(worker: worker)
        let viewModel = PYMainViewModel(interactor: interactor)
        let view = PYMainPageView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
