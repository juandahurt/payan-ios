//
//  PYMenuInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation
import Combine

class PYMenuInteractor: PYMenuBusinessLogic {
    var worker: PYMenuDataAccessLogic
    
    init(worker: PYMenuDataAccessLogic) {
        self.worker = worker
    }
    
    func getSections() -> AnyPublisher<[PYMenuSection], Error> {
        worker.getSections()
    }
}
