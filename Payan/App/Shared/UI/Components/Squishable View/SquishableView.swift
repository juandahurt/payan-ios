//
//  SquishableView.swift
//  Payan
//
//  Created by juandahurt on 10/11/21.
//

import Foundation
import UIKit

extension UIView  {
    func makeSquihable() {
        setupTapGesture()
    }
    
    fileprivate func setupTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(squish))
        addGestureRecognizer(gesture)
    }
    
    @objc
    fileprivate func squish() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.autoreverse], animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { [weak self] done in
            if done {
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
