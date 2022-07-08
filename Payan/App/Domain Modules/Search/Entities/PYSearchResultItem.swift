//
//  PYSearchResultItem.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Foundation

struct PYSearchResultItem: Decodable {
    var title: String
    var deepLink: String
}

extension PYSearchResultItem: Equatable {
    static func ==(lhs: PYSearchResultItem, rhs: PYSearchResultItem) -> Bool {
        lhs.title == rhs.title
    }
}
