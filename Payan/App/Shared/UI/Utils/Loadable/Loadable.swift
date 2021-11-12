//
//  Loadable.swift
//  Payan
//
//  Created by juandahurt on 19/09/21.
//

import Foundation
import UIKit

protocol Loadable {
    func showLoader()
    func hideLoader()
}

class LoadableButton: SquishableButton, Loadable {
    private var activityIndicator: UIActivityIndicatorView?
    
    private func createIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.color = .white
        activityIndicator?.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    }
    
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                if self.activityIndicator == nil {
                    self.createIndicator()
                }
                self.isUserInteractionEnabled = false
                self.titleLabel?.removeFromSuperview()
                self.addSubview(self.activityIndicator!)
                self.activityIndicator!.startAnimating()
            }
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                self.activityIndicator!.stopAnimating()
                self.activityIndicator!.removeFromSuperview()
                self.isUserInteractionEnabled = true
                self.addSubview(self.titleLabel!)
            }
        }
    }
}
