//
//  PYHSectionLayout.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Foundation

struct PYHSectionLayout {
    let type: PYHSectionLayoutType
    let dimensions: PYHSectionItemDimensions?
}

struct PYHSectionItemDimensions {
    let width: Int
    let height: Int
}
