//
//  PYCDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


protocol PYCDataAccessLogic {
    func getPlaces(withTypeId typeId: String, completion: @escaping (Result<PYCollection, Error>) -> Void)
}
