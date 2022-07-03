//
//  PYSearchCoreBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Foundation
import SwiftUI

class PYSearchCoreBuilder: PYModuleBuilder {
    func build(params: [URLQueryItem]) -> UIViewController? {
        UIHostingController(rootView: PYSearchCorePageView())
    }
}
