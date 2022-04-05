//
//  PYHInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation


final class PYHInteractor {
    let worker = PYHWorker()
    
    func checkCurrentVersion() {
        worker.getLastVersion { version in
            dump(version)
        }
    }
}
