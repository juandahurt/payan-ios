//
//  PYCollectionDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCollectionDataAccessLogic {
    func getCollection(withTypeId typeId: String, completion: @escaping (Result<PYCollection, Error>) -> Void)
}
