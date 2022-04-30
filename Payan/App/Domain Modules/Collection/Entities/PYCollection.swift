//
//  PYCollection.swift
//  Payan
//
//  Created by Juan David Hurtado Molano on 30/04/22.
//

import Foundation

struct PYCollection: Decodable {
    var title: String
    var elements: [PYCollectionPlace]
}
