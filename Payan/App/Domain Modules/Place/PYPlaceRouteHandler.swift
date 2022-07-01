//
//  PYPlaceRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation

class PYPlaceRouteHandler: BasicRouteHandler {
    var routes: [Route] = []
    var host: String {
        "place"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            PYPlaceBuilder()
        ]
    }
}
