//
//  PYStoryPreview.swift
//  Payan
//
//  Created by Juan Hurtado on 23/07/22.
//

import Foundation

struct PYStoryPreview: Decodable {
    var id: String
    var link: String
    var title: String
    var image: String
    var hash: String
}

extension PYStoryPreview {
    static let skeleton: [PYStoryPreview] = [
        .init(id: "", link: "", title: "", image: "", hash: ""),
        .init(id: "", link: "", title: "", image: "", hash: ""),
        .init(id: "", link: "", title: "", image: "", hash: ""),
    ]
}
