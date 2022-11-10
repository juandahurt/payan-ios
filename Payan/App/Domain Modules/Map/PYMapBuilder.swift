//
//  PYMapBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 27/09/22.
//

import Foundation
import SwiftUI
import UIKit

class PYMapBuilder {
    func build() -> UIViewController {
        let store = AppStore(
            initialState: PYMapState(),
            reducer: PYMapReducer(repository: PYMapWebRepository()),
            environment: "" // TODO: remove unnecesary object
        )
        let view = PYMapPageView()
            .environmentObject(store)
        return UIHostingController(rootView: view)
    }
}
