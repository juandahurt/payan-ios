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
                _shared = PYRoutingManager()
            }
            return _shared!
        }
    }
    
    private var modules: [PYModule] = []
    
    private init() {}
    
    func addModule(_ module: PYModule) {
        modules.append(module)
    }
    
    func open(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }
        guard let module = modules.first(where: { $0.route == components.host }) else { return }
        module.open(params: components.queryItems ?? [])
    }
}
