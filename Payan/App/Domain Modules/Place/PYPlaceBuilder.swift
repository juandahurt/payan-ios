//
//  PYPlaceBuilder.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation
import SwiftUI

final class PYPlaceBuilder: Route {
    var path: String = ""
    
    var builder: ([URLQueryItem]) -> UIViewController? = { params in
        guard !params.isEmpty, params[0].name == "id", let placeId = params[0].value else { return nil }
        return UIHostingController(rootView: PYPlacePageView(placeId: placeId))
    }
}
