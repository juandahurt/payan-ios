//
//  PYMainInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 24/06/22.
//

import Foundation

class PYMainInteractor: PYMainBusinessLogic {
    private let worker: PYMainDataAccessLogic
    
    init(worker: PYMainDataAccessLogic) {
        self.worker = worker
    }
    
    func checkIfUserHasSeenOnboarding() -> Bool {
        worker.getUserHasSeenOnboarding()
    }
    
    func saveUserSawOnboarding() {
        worker.saveUserSawOnboarding()
    }
}
