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
    var navigationBarIsHidden = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = navigationBarIsHidden
    }
    
    /// Shows or hides the tab bar.
    ///
    /// This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time.
    /// - Parameters:
    ///   - visible: Indicates if you want to show the tab bar or not.
    ///   - animated: `true` if you want an animation.
    func setTabBarVisible(visible: Bool, animated: Bool) {
        if (tabBarIsVisible() == visible) { return }
        
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    /// Indicates if the tab bar is visible or not.
    /// - Returns: `true` if tab bar is visible.
    func tabBarIsVisible() -> Bool {
        return (self.tabBarController?.tabBar.frame.origin.y)! < self.view.frame.maxY
    }
    
    /// Hides all the subviews and shows the loading animation.
    func showLoading(hidesSubviews: Bool = true) {
        // hide subviews
        if hidesSubviews {
            view.subviews.forEach {
                $0.alpha = 0
            }
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
