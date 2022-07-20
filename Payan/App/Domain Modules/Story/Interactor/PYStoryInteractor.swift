//
//  PYStoryInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 20/07/22.
//

import Combine

class PYStoryInteractor: PYStoryBusinessLogic {
    let worker: PYStoryDataAccessLogic
    
    init(worker: PYStoryDataAccessLogic) {
        self.worker = worker
    }
    
    func next(currentIndex: inout Int, numberOfChapters: Int) {
        guard currentIndex < numberOfChapters - 1 else { return }
        currentIndex += 1
    }
    
    func back(currentIndex: inout Int, numberOfChapters: Int) {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }
    
    func getStory(identifiedBy id: String) -> AnyPublisher<[PYStoryChapter], Error> {
        worker.getStory(id: id)
    }
}
