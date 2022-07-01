//
//  PYCollectionRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation
import SwiftUI
import UIKit

class PYCollectionRouteHandler: BasicRouteHandler {
    var routes: [Route] = []
    var host: String {
        "collection"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            PYCollectionBuilder()
        ]
    }
}
