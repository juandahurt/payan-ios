//
//  PYBaseViewController.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class PYBaseViewController: UIViewController {
    /// Hides all the subviews and shows the loading animation.
    func showLoading() {
        // hide subviews
        view.subviews.forEach {
            $0.alpha = 0
        }
        
        let indicator = NVActivityIndicatorView(
            frame: .init(x: 0, y: 0, width: 80, height: 80),
            type: .circleStrokeSpin,
            color: AppStyle.Color.G2
        )
        indicator.startAnimating()
        view.addSubview(indicator)
        indicator.center = view.center
    }
    
    /// Shows all the subviews and hides the loading animation
    func hideLoading() {
        // show subviews
        view.subviews.forEach {
            $0.alpha = 1
            if let indicator = $0 as? NVActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
