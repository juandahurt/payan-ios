//
//  PYSearchCoreRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 2/07/22.
//

import Foundation

class PYSearchCoreRouteHandler: PYBasicRouteHandler {
    var routes: [(builder: PYModuleBuilder, path: String)] = []
    
    var host: String = "search"
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            (builder: PYSearchCoreBuilder(), path: "")
        ]
    }
}
