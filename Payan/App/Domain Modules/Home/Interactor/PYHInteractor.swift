//
//  PYHInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation


final class PYHInteractor: PYHBusinessLogic {
    var worker: PYHDataAccessLogic
    
    init(worker: PYHDataAccessLogic = PYHWorker()) {
        self.worker = worker
    }
    
    func checkCurrentVersion() {
        worker.getLastVersion { version in
            dump(version)
        }
    }
}
