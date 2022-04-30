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
    var elementLayout: PYFeedElementLayout
    var header: PYFeedSectionHeader
    var elements: [PYFeedSectionElement]
    
    enum CodingKeys: String, CodingKey {
        case layout, header, elements, elementLayout
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = ""
        layout = try container.decode(PYFeedSectionLayout.self, forKey: .layout)
        elementLayout = try container.decode(PYFeedElementLayout.self, forKey: .elementLayout)
        header = try container.decode(PYFeedSectionHeader.self, forKey: .header)
        elements = try container.decode([PYFeedSectionElement].self, forKey: .elements)
    }
    
    init(layout: PYFeedSectionLayout, elementLayout: PYFeedElementLayout, header: PYFeedSectionHeader, elements: [PYFeedSectionElement]) {
        self.layout = layout
        self.elementLayout = elementLayout
        self.header = header
        self.elements = elements
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
