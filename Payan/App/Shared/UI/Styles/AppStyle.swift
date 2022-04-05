//
//  AppStyle.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import Foundation
import UIKit

struct AppStyle {
    struct Color {
        static var primary: UIColor {
            UIColor(named: "Primary") ?? .black
        }
        
        static var G1: UIColor {
            UIColor(named: "G1") ?? .gray
        }
        
        static var G2: UIColor {
            UIColor(named: "G2") ?? .gray
        }
        
        static var G7: UIColor {
            UIColor(named: "G7") ?? .gray
        }
        static var N1: UIColor {
            UIColor(named: "N1") ?? .black
        }
        
        
        static var N8: UIColor {
            UIColor(named: "N8") ?? .gray
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
            case title = 18
            case subtitle = 14
            case body = 12
            case footer = 10
        }
        
        enum Weight: String {
            case regular = "Poppins-Regular"
            case medium = "Poppins-Medium"
            case semiBold = "Poppins-SemiBold"
        }
        
        static func get(_ weight: Weight, size: Size) -> UIFont {
            UIFont(name: weight.rawValue, size: size.rawValue)!
        }
    }
}
