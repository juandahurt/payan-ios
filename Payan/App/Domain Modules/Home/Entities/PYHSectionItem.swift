//
//  PYHSectionItem.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Foundation


class PYHSectionItem: Decodable {
    var id: String = ""
    let title: String
    let subtitle: String?
    let image: String
    
    enum CodingKeys: CodingKey {
        case title, image, subtitle
    }
    
    required init(from decoder: Decoder) throws {
        id = ""
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
    }
    
    init() {
        title = ""
        image = ""
        subtitle = nil
    }
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
