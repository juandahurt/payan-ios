//
//  PYFeedElementLayout.swift
//  Payan
//
//  Created by Juan Hurtado on 24/04/22.
//

import Foundation

struct PYFeedElementLayout: Decodable {
    let type: PYFeedElementLayoutType
    let dimensions: PYFeedSectionElementDimensions?
}

struct PYFeedSectionElementDimensions: Decodable {
    let width: Int
    let height: Int
}
