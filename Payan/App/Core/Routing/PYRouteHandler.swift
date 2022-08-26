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

enum PYRoutePresentationType {
    case push
    case present
}

protocol PYBasicRouteHandler: PYRouteHandler {
    var routes: [
        (builder: PYModuleBuilder, path: String, type: PYRoutePresentationType)
    ] { get }
}

protocol PYTabbedRouteHandler: PYRouteHandler {
    var tabItems: [(index: Int, path: String)] { get }
}
