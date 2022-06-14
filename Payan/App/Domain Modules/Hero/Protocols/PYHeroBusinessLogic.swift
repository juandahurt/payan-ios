//
//  PYHeroBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 14/06/22.
//

import Foundation

protocol PYHeroBusinessLogic {
    var worker: PYHeroDataAccessLogic { get }
    
    func getHero(identifiedBy id: String, completion: @escaping (Result<PYHero, Error>) -> Void)
}
