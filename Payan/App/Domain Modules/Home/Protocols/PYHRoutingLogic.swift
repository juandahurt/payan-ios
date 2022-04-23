//
//  PYHRoutingLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation
import UIKit


protocol PYHRoutingLogic {
    var viewController: UIViewController? { get set }
    
    func show()
    func showCategory()
}
