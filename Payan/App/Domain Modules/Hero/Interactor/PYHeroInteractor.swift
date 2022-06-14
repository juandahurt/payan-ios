//
//  PYHeroInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 14/06/22.
//

import Foundation

class PYHeroInteractor: PYHeroBusinessLogic {
    var worker: PYHeroDataAccessLogic
    
    init(worker: PYHeroDataAccessLogic) {
        self.worker = worker
    }
    
    func getHero(identifiedBy id: String, completion: @escaping (Result<PYHero, Error>) -> Void) {
        worker.fetchHero(identifiedBy: id) { res in
            completion(res)
        }
    }
}
