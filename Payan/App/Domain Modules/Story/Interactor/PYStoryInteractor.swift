//
//  PYStoryInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 20/07/22.
//

import Combine
import Foundation

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
}
