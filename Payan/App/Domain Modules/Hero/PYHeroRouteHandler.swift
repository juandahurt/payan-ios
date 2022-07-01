//
//  PYHeroRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation

class PYHeroRouteHandler: PYBasicRouteHandler {
    var routes: [(builder: PYModuleBuilder, path: String)] = []
    var host: String {
        "hero"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            (builder: PYHeroBuilder(), path: "")
        ]
    }
}
