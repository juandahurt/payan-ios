//
//  PYSearchResult.swift
//  Payan
//
//  Created by Juan Hurtado on 3/07/22.
//

import Foundation

struct PYSearchResult {
    var title: String
    var items: [PYSearchResultItem]
}

extension PYSearchResult {
    static let dummy = [
        PYSearchResult(title: "Lugares", items: [
            .init(title: "Puente del humilladero"),
            .init(title: "Puente Viejo del Cauca"),
            .init(title: "Parque Caldas"),
            .init(title: "La Ermita"),
            .init(title: "San Francisco"),
        ]),
        PYSearchResult(title: "Próceres", items: [
            .init(title: "Francisco José de Caldas"),
            .init(title: "Tomás Cipriano de Mosquera"),
            .init(title: "Ezequiel Hurtado"),
        ])
    ]
}
