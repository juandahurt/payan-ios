//
//  PYHSection.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Foundation

class PYHSection: Decodable {
    var id: String = ""
    var layout: PYHSectionLayout
    var itemLayout: PYHItemLayout
    var header: PYHSectionHeader
    var items: [PYHSectionItem]
    
    enum CodingKeys: String, CodingKey {
        case layout, header
        case items = "elements"
        case itemLayout = "elementLayout"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = ""
        layout = try container.decode(PYHSectionLayout.self, forKey: .layout)
        itemLayout = try container.decode(PYHItemLayout.self, forKey: .itemLayout)
        header = try container.decode(PYHSectionHeader.self, forKey: .header)
        items = try container.decode([PYHSectionItem].self, forKey: .items)
    }
    
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
