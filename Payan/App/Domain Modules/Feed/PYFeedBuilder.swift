//
//  PYFeedBuilder.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit
import SwiftUI

final class PYFeedBuilder {
    func getViewController() -> UIViewController {
        let worker = PYFeedNetworkWorker()
        let interactor = PYFeedInteractor(worker: worker)
        let viewModel = PYFeedViewModel(interactor: interactor)
        return UIHostingController(rootView: PYFeedPageView(viewModel: viewModel))
    }
}
