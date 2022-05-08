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
  
    enum CodingKeys: CodingKey {
        case image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        image = try container.decodeIfPresent(String.self, forKey: .image)
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
