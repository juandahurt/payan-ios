//
//  PYPlaceDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation

protocol PYPlaceDataAccessLogic {
    func fecthPlace(id: String, completion: @escaping (Result<PYPlace,Error>) -> Void)
}
