//
//  PYMenuItem.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation

struct PYMenuItem {
    var image: String
    var title: String
    var content: String
}

extension PYMenuItem {
    static let defaultItems: [PYMenuItem] = [
        .init(
            image: "help",
            title: "¿Qué es Payán?",
            content: "Payán es un proyecto sin ánimo de lucro cuyo principal objetivo es mostrar al mundo al belleza e historia que esconde Popayán, Colombia."
        )
    ]
}
