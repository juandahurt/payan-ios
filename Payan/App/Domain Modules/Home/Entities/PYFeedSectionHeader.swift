//
//  PYFeedSectionHeader.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation

struct PYFeedSectionHeader: Decodable {
    var title: String
    var subtitle: String?
    var secondaryButton: PYFeedHeaderButton?
}
