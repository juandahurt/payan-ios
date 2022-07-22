//
//  PYStoryRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 21/07/22.
//

import Foundation

class PYStoryRouteHandler: PYBasicRouteHandler {
    var routes: [(builder: PYModuleBuilder, path: String, type: PYRoutePresentationType)] = []
    
    var host: String {
        "story"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            (builder: PYStoryBuilder(), path: "", type: .present)
        ]
    }
}
