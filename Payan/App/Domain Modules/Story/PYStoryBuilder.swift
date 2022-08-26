//
//  PYStoryBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 20/07/22.
//

import Foundation
import SwiftUI

class PYStoryBuilder {
    func build(data: PYStoryData, onSeenStory: (() -> Void)?) -> UIViewController {
        let worker = PYStoryNetworkWorker()
        let interactor = PYStoryInteractor(worker: worker)
        let viewModel = PYStoryViewModel(interactor: interactor, chapters: data.chapters)
        let view = PYStoryPageView(viewModel: viewModel, onSeenStory: onSeenStory)
        return UIHostingController(rootView: view)
    }
}
