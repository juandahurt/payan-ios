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
    var layout: PYCollectionLayout
    
    init(title: String = "", elements: [PYCollectionElement] = []) {
        self.title = title
        self.elements = elements
        self.layout = .normal
    }
}

class PYLoadingCollection: PYCollection {
    init() {
        super.init(title: "", elements: [PYCollectionElement](repeating: PYCollectionElement(title: "", image: ""), count: 12))
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
