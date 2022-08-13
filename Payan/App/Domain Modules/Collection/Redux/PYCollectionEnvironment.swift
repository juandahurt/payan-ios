//
//  PYCollectionEnvironment.swift
//  Payan
//
//  Created by Juan Hurtado on 13/08/22.
//

import Foundation

class PYCollectionEnvironment {
    let worker: PYCollectionDataAccessLogic
    
    init(worker: PYCollectionDataAccessLogic = PYCollectionNetworkWorker()) {
        self.worker = worker
    }
}
