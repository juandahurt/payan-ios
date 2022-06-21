//
//  PYMenuViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation
import Combine

class PYMenuViewModel: ObservableObject {
    @Published var items: [PYMenuItem] = []
    @Published var selectedItem: PYMenuItem?
    
    let interactor: PYMenuBusinessLogic
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: PYMenuBusinessLogic = PYMenuInteractor(worker: PYMenuLocalWorker())) {
        self.interactor = interactor
    }
    
    func getItems() {
        interactor.getItems()
            .sink { _ in } receiveValue: { items in
                self.items = items
            }
            .store(in: &cancellables)
    }
    
    func select(item: PYMenuItem) {
        selectedItem = item
    }
}
