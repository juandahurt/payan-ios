//
//  PYModule.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 26/04/22.
//

import Foundation
import UIKit

protocol PYModule {
    typealias Params = [URLQueryItem]
    var route: String { get }
    var navigationController: UINavigationController { get }
    
    func open(params: [URLQueryItem])
}
