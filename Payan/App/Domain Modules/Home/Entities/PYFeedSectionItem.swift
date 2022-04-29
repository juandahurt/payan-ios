//
//  PYFeedSectionItem.swift
//  Payan
//
//  Created by Juan Hurtado on 15/04/22.
//

import Foundation


class PYFeedSectionItem: Decodable {
    var id: String = ""
    let title: String
    let subtitle: String?
    let image: String
    let link: String
    
    enum CodingKeys: CodingKey {
        case title, image, subtitle, link
    }
    
    required init(from decoder: Decoder) throws {
        id = ""
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        link = try container.decode(String.self, forKey: .link)
    }
    
    init() {
        title = ""
        image = ""
        subtitle = nil
        link = ""
    }
}

extension PYFeedSectionItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PYFeedSectionItem, rhs: PYFeedSectionItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Loading section item
class PYFeedLoadingSectionItem: PYFeedSectionItem {}
