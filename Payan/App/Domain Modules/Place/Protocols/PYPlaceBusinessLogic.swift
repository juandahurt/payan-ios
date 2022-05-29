//
//  PYPlaceBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation

protocol PYPlaceBusinessLogic {
    var worker: PYPlaceDataAccessLogic { get }
    
    func getPlace(identifiedBy id: String, completion: @escaping (Result<PYPlace,Error>) -> Void)
}
