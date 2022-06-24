//
//  PYMainViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 24/06/22.
//

import Foundation

class PYMainViewModel: ObservableObject {
    private let interactor: PYMainBusinessLogic
    @Published var userHasSeenOnboarding = false
    
    init(interactor: PYMainBusinessLogic) {
        self.interactor = interactor
    }
    
    func checkIfUserHasSeenOnboarding() {
        userHasSeenOnboarding = interactor.checkIfUserHasSeenOnboarding()
    }
    
    func saveUserSawOnboarding() {
        interactor.saveUserSawOnboarding()
        userHasSeenOnboarding = true
    }
}
