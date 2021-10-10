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
    
    static var textFieldForm: UIColor {
        UIColor(named: "TextFieldForm") ?? .lightGray
    }
    
    static var background: UIColor {
        UIColor(named: "Background") ?? .systemGray
    }
    
    static var skeleton: UIColor {
        UIColor(named: "Skeleton") ?? .systemGray
    }
}

struct UIConstants {
    static let buttonCornerRadius: CGFloat = 20
    static let textFieldFormPadding: CGFloat = 10
    static let textFieldCornerRadius: CGFloat = 10
}

struct Font {
    enum Size: CGFloat {
        case header = 22
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
