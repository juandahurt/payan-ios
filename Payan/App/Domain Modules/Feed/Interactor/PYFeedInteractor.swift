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
    var storySeenWorker: PYStorySeenDataAccessLogic
    
    init(worker: PYFeedDataAccessLogic, storyWorker: PYStoryDataAccessLogic, storySeenWorker: PYStorySeenDataAccessLogic) {
        self.worker = worker
        self.storyWorker = storyWorker
        self.storySeenWorker = storySeenWorker
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
    
    func saveSeenStory(hash: String) {
        var stories = storySeenWorker.getSeenStories()
        if !stories.contains(where: { $0 == hash }) {
            stories.append(hash)
        }
        storySeenWorker.setSeenStories(hashes: stories)
        dump(stories)
    }
    
    func getSeenStories() -> [String] {
        storySeenWorker.getSeenStories()
    }
}
