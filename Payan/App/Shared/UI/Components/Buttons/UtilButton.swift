//
//  UtilButton.swift
//  Payan
//
//  Created by juandahurt on 16/11/21.
//

import Foundation
import UIKit

final class UtilButton: SquishableButton {
    override var background: UIColor? {
        AppStyle.Color.primary.withAlphaComponent(0.25)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = frame.width / 2
    }
}
