//
//  PYHSection.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Foundation

class PYHSection {
    var id: String = ""
    var layout: PYHSectionLayout
    var itemLayout: PYHItemLayout
    var header: PYHSectionHeader
    var items: [PYHSectionItem]
    
    init(layout: PYHSectionLayout, itemLayout: PYHItemLayout, header: PYHSectionHeader, items: [PYHSectionItem]) {
        self.layout = layout
        self.itemLayout = itemLayout
        self.header = header
        self.items = items
    }
}

extension PYHSection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PYHSection, rhs: PYHSection) -> Bool {
        lhs.id == rhs.id
    }
}
