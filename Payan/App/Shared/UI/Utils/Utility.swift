//
//  Utility.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import Foundation
import UIKit

struct Utility {
    static func addShadow(to view: UIView, radius: CGFloat = 8, offset: CGSize = CGSize(width: 0, height: 4), opacity: Float = 0.05) {
        view.layer.shadowRadius = radius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowOpacity = opacity
        view.layer.masksToBounds = false
    }
}
