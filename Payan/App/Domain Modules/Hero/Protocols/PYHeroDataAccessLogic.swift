//
//  PYHeroDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 14/06/22.
//

import Foundation

protocol PYHeroDataAccessLogic {
    func fetchHero(identifiedBy id: String, completion: @escaping (Result<PYHero, Error>) -> Void)
}
