//
//  SecondaryButton.swift
//  Payan
//
//  Created by juandahurt on 3/11/21.
//

import Foundation
import UIKit

final class SecondaryButton: SquishableButton {
    override var background: UIColor? {
        Color.background
    }
    
    override var textColor: UIColor? {
        Color.primary
    }
}
