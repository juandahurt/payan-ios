//
//  PYCollectionDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Combine
import Foundation

protocol PYCollectionDataAccessLogic {
    func getCollection(type: String, categoryId: String?) -> AnyPublisher<PYCollection, Error>
}
