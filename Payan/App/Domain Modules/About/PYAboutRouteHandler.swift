//
//  PYAboutRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation

class PYAboutRouteHandler: PYBasicRouteHandler {
    var routes: [(builder: PYModuleBuilder, path: String)] = []
    var host: String {
        "about"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            (builder: PYAboutBuilder(), path: "")
        ]
    }
}
