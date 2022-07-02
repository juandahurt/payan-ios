//
//  PYFeedInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation


final class PYFeedInteractor: PYFeedBusinessLogic {
    var worker: PYFeedDataAccessLogic
    
    init(worker: PYFeedDataAccessLogic) {
        self.worker = worker
    }
    
    func getFeedData(completion: @escaping (Result<PYFeedPage,Error>) -> Void) {
        worker.getData { res in
            DispatchQueue.main.async {
                switch res {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
