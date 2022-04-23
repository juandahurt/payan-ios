//
//  PYHSectionItem.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Foundation


class PYHSectionItem {
    var id: String = ""
}

extension PYHSectionItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PYHSectionItem, rhs: PYHSectionItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Loading section item
class PYHLoadingSectionItem: PYHSectionItem {}
