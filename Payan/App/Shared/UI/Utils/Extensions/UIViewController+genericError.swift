//
//  UIViewController+genericError.swift
//  Payan
//
//  Created by Juan Hurtado on 3/05/22.
//

import Foundation
import UIKit


extension UIViewController {
    /// Shows the generic error.
    /// - Parameter delegate: generic error delegate
    func showGenericError(onDisappear: @escaping () -> Void) {
        let vc = PYGenericErrorViewController()
        vc.modalPresentationStyle = .currentContext
        vc.onDisappear = onDisappear
        navigationController?.present(vc, animated: false)
    }
}
