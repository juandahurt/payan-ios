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
    func build(onSuccess: (() -> Void)?) -> UIViewController {
        let worker = PYFeedNetworkWorker()
        let storyWorker = PYStoryNetworkWorker()
        let interactor = PYFeedInteractor(worker: worker, storyWorker: storyWorker)
        let viewModel = PYFeedViewModel(interactor: interactor, onSuccess: onSuccess)
        return UIHostingController(rootView: PYFeedPageView(viewModel: viewModel))
    }
}
