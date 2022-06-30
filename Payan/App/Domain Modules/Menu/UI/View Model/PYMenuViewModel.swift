//
//  PYMenuViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation
import Combine

class PYMenuViewModel: ObservableObject {
    @Published var sections: [PYMenuSection] = []
    
    let interactor: PYMenuBusinessLogic
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: PYMenuBusinessLogic = PYMenuInteractor(worker: PYMenuLocalWorker())) {
        self.interactor = interactor
    }
    
    func getSections() {
        interactor.getSections()
            .sink { _ in } receiveValue: { sections in
                self.sections = sections
            }
            .store(in: &cancellables)
    }
}
