//
//  PYRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation

protocol PYRouteHandler {
    var host: String { get }
    
    func configure()
}

protocol PYBasicRouteHandler: PYRouteHandler {
    var routes: [
        (builder: PYModuleBuilder, path: String)
    ] { get }
}

protocol PYTabbedRouteHandler: PYRouteHandler {
    var tabItems: [(index: Int, path: String)] { get }
}
