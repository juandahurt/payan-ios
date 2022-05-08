//
//  PYElementSectionItem.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementSectionItem: Decodable {
    var id: String
    var image: String?
    var title: String?
    var subtitle: String?
    var content: String?
    
    enum CodingKeys: CodingKey {
        case image, title, subtitle, content
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        image = try container.decodeIfPresent(String.self, forKey: .image)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        content = try container.decodeIfPresent(String.self, forKey: .content)
    }
    
    init() {
        id = UUID().uuidString
    }
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
