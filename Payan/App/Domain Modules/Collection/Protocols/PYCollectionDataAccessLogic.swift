//
//  PYCollectionDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCollectionDataAccessLogic {
    func getCollection(ofType type: String, categoryId: String?, completion: @escaping (Result<PYCollection, Error>) -> Void)
}
