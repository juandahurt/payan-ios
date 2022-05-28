//
//  UIViewController+popGesture.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation
import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
