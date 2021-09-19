//
//  AppStyle.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import Foundation
import UIKit

struct Color {
    static var primary: UIColor {
        UIColor(named: "Primary") ?? .black
    }
}

struct UIConstants {
    static let buttonCornerRadius: CGFloat = 20
}

struct Font {
    enum Size: CGFloat {
        case subtitle = 14
        case body = 12
    }
    
    enum Weight: String {
        case regular = "Poppins-Regular"
        case semiBold = "Poppins-SemiBold"
    }
    
    static func get(_ weight: Weight, size: Size) -> UIFont {
        UIFont(name: weight.rawValue, size: size.rawValue)!
    }
}
