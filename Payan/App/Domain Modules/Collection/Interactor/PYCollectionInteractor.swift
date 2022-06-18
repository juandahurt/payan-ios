//
//  PYCollectionInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


class PYCollectionInteractor: PYCollectionBusinessLogic {
    var worker: PYCollectionDataAccessLogic
    
    init(worker: PYCollectionDataAccessLogic = PYCollectionNetworkWorker()) {
        self.worker = worker
    }
    
    func getCollection(ofType type: String, categoryId: String?, completion: @escaping (Result<PYCollection,Error>) -> Void) {
        worker.getCollection(ofType: type, categoryId: categoryId) { res in
            DispatchQueue.main.async {
                switch res {
                case .success(let collection):
                    completion(.success(collection))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
