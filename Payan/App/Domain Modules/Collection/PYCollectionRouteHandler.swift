//
//  PYCollectionRouteHandler.swift
//  Payan
//
//  Created by Juan Hurtado on 1/07/22.
//

import Foundation
import SwiftUI
import UIKit

class PYCollectionRouteHandler: PYBasicRouteHandler {
    var routes: [(builder: PYModuleBuilder, path: String)] = []
    var host: String {
        "collection"
    }
    
    init() {
        configure()
    }
    
    func configure() {
        routes = [
            (builder: PYCollectionBuilder(), path: "")
        ]
    }
}
