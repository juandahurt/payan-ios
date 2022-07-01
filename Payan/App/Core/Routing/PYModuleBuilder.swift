//
//  PYModuleBuilder.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 26/04/22.
//

import Foundation
import UIKit

protocol PYModuleBuilder {
    func build(params: [URLQueryItem]) -> UIViewController?
}
