//
//  PYCollectionBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCollectionBusinessLogic {
    var worker: PYCollectionDataAccessLogic { get }
    
    func getCollection(ofType type: String, categoryId: String?, completion: @escaping (Result<PYCollection, Error>) -> Void)
}
