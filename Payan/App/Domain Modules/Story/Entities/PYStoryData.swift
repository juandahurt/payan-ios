//
//  PYStoryData.swift
//  Payan
//
//  Created by Juan Hurtado on 23/07/22.
//

import Foundation

struct PYStoryData: Decodable {
    var id: String
    var hash: String
    var chapters: [PYStoryChapter]
    
    enum CodingKeys: CodingKey {
        case hash
        case chapters
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        hash = try container.decode(String.self, forKey: .hash)
        chapters = try container.decode([PYStoryChapter].self, forKey: .chapters)
    }
}

extension PYStoryData: Equatable {
    static func ==(lhs: PYStoryData, rhs: PYStoryData) -> Bool {
        lhs.id == rhs.id
    }
}
