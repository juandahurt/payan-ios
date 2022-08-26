//
//  PYStoryData.swift
//  Payan
//
//  Created by Juan Hurtado on 23/07/22.
//

import Foundation

struct PYStoryData: Decodable {
    var hash: String
    var chapters: [PYStoryChapter]
}
