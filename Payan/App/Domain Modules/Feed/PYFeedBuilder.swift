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
    func build() -> UIViewController {
        let view = PYFeedPageView()
            .environmentObject(
                AppStore(
                    initialState: PYFeedState(),
                    reducer: PYFeedReducer(repository: PYFeedWebRepository(), seenStoryRepostory: PYSeenStoryUserDefaultsRepository())
                )
            )
        return UIHostingController(rootView: view)
    }
}
