//
//  PYHItemLayout.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Foundation

struct PYHItemLayout: Decodable {
    let type: PYHItemLayoutType
    let dimensions: PYHSectionItemDimensions?
}

struct PYHSectionItemDimensions: Decodable {
    let width: Int
    let height: Int
}
