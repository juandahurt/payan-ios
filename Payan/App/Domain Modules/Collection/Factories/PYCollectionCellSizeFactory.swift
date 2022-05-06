//
//  PYCollectionCellSizeFactory.swift
//  Payan
//
//  Created by Juan Hurtado on 6/05/22.
//

import Foundation
import UIKit

class PYCollectionCellSizeFactory {
    static func createSize(for layout: PYCollectionLayout) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        switch layout {
        case .normal:
            return CGSize(width: (screenWidth / 3) - CGFloat(2), height: (screenWidth / 3) - CGFloat(2))
        case .oversized:
            return CGSize(width: screenWidth, height: screenWidth / 2)
        }
    }
}
