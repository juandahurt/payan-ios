//
//  PYHSection.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Foundation

class PYHSection {
    var id: String = ""
    var layout: PYHSectionLayout = .grid
    var itemLayout: PYHItemLayout
    var items: [PYHSectionItem]
    
    init(layout: PYHSectionLayout, itemLayout: PYHItemLayout, items: [PYHSectionItem]) {
        self.layout = layout
        self.itemLayout = itemLayout
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
