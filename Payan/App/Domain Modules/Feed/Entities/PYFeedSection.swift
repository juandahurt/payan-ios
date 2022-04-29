//
//  PYFeedSection.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Foundation

class PYFeedSection: Decodable {
    var id: String = ""
    var layout: PYFeedSectionLayout
    var itemLayout: PYFeedItemLayout
    var header: PYFeedSectionHeader
    var items: [PYFeedSectionItem]
    
    enum CodingKeys: String, CodingKey {
        case layout, header
        case items = "elements"
        case itemLayout = "elementLayout"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = ""
        layout = try container.decode(PYFeedSectionLayout.self, forKey: .layout)
        itemLayout = try container.decode(PYFeedItemLayout.self, forKey: .itemLayout)
        header = try container.decode(PYFeedSectionHeader.self, forKey: .header)
        items = try container.decode([PYFeedSectionItem].self, forKey: .items)
    }
    
    init(layout: PYFeedSectionLayout, itemLayout: PYFeedItemLayout, header: PYFeedSectionHeader, items: [PYFeedSectionItem]) {
        self.layout = layout
        self.itemLayout = itemLayout
        self.header = header
        self.items = items
    }
}

extension PYFeedSection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PYFeedSection, rhs: PYFeedSection) -> Bool {
        lhs.id == rhs.id
    }
}
