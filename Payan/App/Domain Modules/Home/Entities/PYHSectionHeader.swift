//
//  PYHSectionHeader.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation

struct PYHSectionHeader: Decodable {
    var title: String
    var subtitle: String?
    var secondaryButton: PYHHeaderButton?
}
