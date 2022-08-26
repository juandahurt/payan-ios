//
//  PYPlaceBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation
import SwiftUI

final class PYPlaceBuilder: PYModuleBuilder {
    func build(params: [URLQueryItem]) -> UIViewController? {
        guard !params.isEmpty, params[0].name == "id", let placeId = params[0].value else { return nil }
        return UIHostingController(rootView: PYPlacePageView(placeId: placeId))
    }
}
