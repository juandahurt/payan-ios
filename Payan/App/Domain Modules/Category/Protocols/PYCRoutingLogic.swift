//
//  PYCRoutingLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation
import UIKit


protocol PYCRoutingLogic {
    var viewController: UIViewController? { get set }
    func show()
}
