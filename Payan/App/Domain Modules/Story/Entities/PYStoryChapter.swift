//
//  PYStoryChapter.swift
//  Payan
//
//  Created by Juan Hurtado on 12/07/22.
//

import Foundation

struct PYStoryChapter: Decodable {
    var title: String?
    var content: String?
    var media: PYStoryMedia
}

struct PYStoryMedia: Decodable {
    var type: PYStoryMediaType
    var link: String
}

enum PYStoryMediaType: String, Decodable {
    case image = "img", gif
}
