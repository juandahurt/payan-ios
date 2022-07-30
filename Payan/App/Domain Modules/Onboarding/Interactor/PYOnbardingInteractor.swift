//
//  PYOnbardingInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 30/07/22.
//

import Foundation

class PYOnbardingInteractor: PYOnboardingBusinessLogic {
    internal var worker: PYOnboardingDataAccessLogic
    
    init(worker: PYOnboardingDataAccessLogic) {
        self.worker = worker
    }
    
    func getItems() -> [PYOnboardingItem] {
        worker.fetchItems()
    }
    
    func next(currentIndex: inout Int, numberOfItems: Int) {
        guard currentIndex < numberOfItems-1 else { return }
        currentIndex += 1
    }
}
