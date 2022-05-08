//
//  PYElementSectionItem.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementSectionItem {
    let id: String = UUID().uuidString
}

extension PYElementSectionItem: Hashable {
    static func == (lhs: PYElementSectionItem, rhs: PYElementSectionItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class PYElementSectionLoadingItem: PYElementSectionItem {}
