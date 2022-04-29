//
//  PYFeedItemLayout.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Foundation

struct PYFeedItemLayout: Decodable {
    let type: PYFeedItemLayoutType
    let dimensions: PYFeedSectionItemDimensions?
}

struct PYFeedSectionItemDimensions: Decodable {
    let width: Int
    let height: Int
}
