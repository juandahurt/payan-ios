//
//  PYMenuItem.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation

struct PYMenuItem: Decodable {
    var image: String?
    var title: String
    var content: String
    var isStatic: Bool
}
