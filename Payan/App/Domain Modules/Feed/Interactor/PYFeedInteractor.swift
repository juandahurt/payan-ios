//
//  PYFeedInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Combine
import Foundation

final class PYFeedInteractor: PYFeedBusinessLogic {
    var worker: PYFeedDataAccessLogic
    var storyWorker: PYStoryDataAccessLogic
    
    init(worker: PYFeedDataAccessLogic, storyWorker: PYStoryDataAccessLogic) {
        self.worker = worker
        self.storyWorker = storyWorker
    }
    
    func getFeedData(completion: @escaping (Result<PYFeedPageData,Error>) -> Void) {
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
    
    func getStory(identifiedBy id: String) -> AnyPublisher<PYStoryData, Error> {
        storyWorker.getStory(id: id)
    }
}
