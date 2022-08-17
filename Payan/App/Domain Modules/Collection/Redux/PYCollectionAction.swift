//
//  PYCollectionAction.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Foundation

enum PYCollectionAction {
    case setCollection(PYCollection)
    case getCollection(String, String?)
    case errorOcurred
}
