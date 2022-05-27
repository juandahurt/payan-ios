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
    
    private var modules: [PYModule] = []
    private var navigationController: UINavigationController
    
    private init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func provideNavigationController(_ navigationController: UINavigationController) {
        Self._shared = PYRoutingManager(navigationController: navigationController)
    }
    
    func addModule(_ module: PYModule) {
        modules.append(module)
    }
    
    func open(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }
        guard let module = modules.first(where: { $0.host == components.host }) else { return }
        guard let vc = module.getViewController(params: components.queryItems ?? []) else { return }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
