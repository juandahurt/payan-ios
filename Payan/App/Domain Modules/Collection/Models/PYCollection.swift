//
//  PYCollection.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 30/04/22.
//

import Foundation

class PYCollection: Decodable {
    var title: String
    var elements: [PYCollectionElement]
    
    init(title: String = "", elements: [PYCollectionElement] = []) {
        self.title = title
        self.elements = elements
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case elements = "items"
    }
}
