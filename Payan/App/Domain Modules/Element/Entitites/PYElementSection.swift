//
//  PYElementSection.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementSection: Decodable {
    var id: String
    var items: [PYElementSectionItem] = []
    let itemLayout: PYElementSectionItemLayout
    
    enum CodingKeys: CodingKey {
        case items, itemLayout
    }
    
    init(itemLayout: PYElementSectionItemLayout, items: [PYElementSectionItem]) {
        self.id = UUID().uuidString
        self.itemLayout = itemLayout
        self.items = items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        items = try container.decode([PYElementSectionItem].self, forKey: .items)
        itemLayout = try container.decode(PYElementSectionItemLayout.self, forKey: .itemLayout)
    }
}

extension PYElementSection: Hashable {
    static func == (lhs: PYElementSection, rhs: PYElementSection) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
