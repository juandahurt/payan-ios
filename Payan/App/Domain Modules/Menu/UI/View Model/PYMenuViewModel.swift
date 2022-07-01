//
//  PYMenuViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation
import Combine

class PYMenuViewModel: ObservableObject {
    @Published private(set) var sections: [PYMenuSection] = []
    
    let interactor: PYMenuBusinessLogic
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: PYMenuBusinessLogic = PYMenuInteractor(worker: PYMenuLocalWorker())) {
        self.interactor = interactor
    }
    
    func item(at indexPath: IndexPath) -> PYMenuItem {
        sections[indexPath.section].items[indexPath.item]
    }
    
    func section(at index: Int) -> PYMenuSection {
        sections[index]
    }
    
    func getSections() {
        interactor.getSections()
            .sink { _ in } receiveValue: { sections in
                print(sections)
                self.sections = sections
            }
            .store(in: &cancellables)
    }
}
