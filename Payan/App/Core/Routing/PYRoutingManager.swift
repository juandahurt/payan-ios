//
//  PYRoutingManager.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 26/04/22.
//

import Foundation
import UIKit

class PYRoutingManager {
    private static var _shared: PYRoutingManager?
    static var shared: PYRoutingManager {
        get {
            if _shared == nil {
                fatalError("You have not provided a navigation controller. Use the provideNavigationController() method.")
            }
            return _shared!
        }
    }
    
    private var routeHandlers: [PYRouteHandler] = []
    private var navigationController: UINavigationController
    
    private init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func provideNavigationController(_ navigationController: UINavigationController) {
        Self._shared = PYRoutingManager(navigationController: navigationController)
    }
    
    func addRouteHandler(routeHandler: PYRouteHandler) {
        routeHandlers.append(routeHandler)
    }
    
    func open(url: URL, animated: Bool = true) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        guard let handler = routeHandlers.first(where: { $0.host == components.host }) else { return }

        if let tabbedHandler = handler as? PYTabbedRouteHandler, navigationController.viewControllers[0] is UITabBarController {
            guard let item = tabbedHandler.tabItems.first(where: { $0.path == components.path }) else { return }
            navigationController.popToRootViewController(animated: false)
            let tabBarController = (navigationController.viewControllers[0] as? UITabBarController)
            tabBarController?.selectedIndex = item.index
        } else if let handler = handler as? PYBasicRouteHandler {
            guard let route = handler.routes.first(where: { $0.path == components.path }) else { return }
            guard let vc = route.builder.build(params: components.queryItems ?? []) else { return }
            navigationController.pushViewController(vc, animated: animated)
        }
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func push(_ vc: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        navigationController.viewControllers = viewControllers
    }
}
