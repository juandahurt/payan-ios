//
//  PYPlaceRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation

class PYPlaceRouteHandler: PYBasicRouteHandler {
    var routes: [(builder: PYModuleBuilder, path: String, type: PYRoutePresentationType)] = []
    var host: String {
        "place"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            (builder: PYPlaceBuilder(), path: "", type: .push)
        ]
    }
}
