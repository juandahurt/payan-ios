//
//  PYModule.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 26/04/22.
//

import Foundation
import UIKit

protocol PYModule {
    var host: String { get }
    
    func getViewController(params: [URLQueryItem]) -> UIViewController?
}

protocol RouteHandler {
    var host: String { get }
    
    func configure()
}

protocol BasicRouteHandler: RouteHandler {
    var routes: [Route] { get }
}

protocol TabbedRouteHandler: RouteHandler {
    var tabItems: [(index: Int, path: String)] { get }
}

protocol Route {
    var path: String { get }
    var builder: ([URLQueryItem]) -> UIViewController? { get }
}
