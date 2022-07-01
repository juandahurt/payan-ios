//
//  PYHeroRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation

class PYHeroRouteHandler: BasicRouteHandler {
    var routes: [Route] = []
    var host: String {
        "hero"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            PYHeroBuilder()
        ]
    }
}
