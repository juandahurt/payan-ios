//
//  PYPlaceInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation

class PYPlaceInteractor: PYPlaceBusinessLogic {
    var worker: PYPlaceDataAccessLogic
    
    init(worker: PYPlaceDataAccessLogic = PYPlaceNetworkWorker()) {
        self.worker = worker
    }
    
    func getPlace(identifiedBy id: String, completion: @escaping (Result<PYPlace, Error>) -> Void) {
        worker.fecthPlace(id: id) { res in
            DispatchQueue.main.async {
                switch res {
                case .success(let place):
                    completion(.success(place))
                case .failure(_): break
                }
            }
        }
    }
}
