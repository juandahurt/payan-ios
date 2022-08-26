//
//  PYMainRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation

class PYMainRouteHandler: PYTabbedRouteHandler {
    var host: String {
        "base"
    }
    
    var tabItems: [(index: Int, path: String)] = []
    
    init() {
        configure()
    }
    
    func configure() {
        tabItems = [
            (index: 0, path: "/home"),
            (index: 1, path: "/menu"),
        ]
    }
}
