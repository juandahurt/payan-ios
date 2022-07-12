//
//  PYCollectionViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 26/05/22.
//

import Foundation

class PYCollectionViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var collection: PYCollection = .skeleton
    @Published var errorHasOccured = false

    let interactor: PYCollectionBusinessLogic
    
    init(interactor: PYCollectionBusinessLogic = PYCollectionInteractor()) {
        self.interactor = interactor
    }
    
    func getCollection(ofType type: String, categoryId: String?) {
        isLoading = true
        interactor.getCollection(ofType: type, categoryId: categoryId) { [weak self] res in
            guard let self = self else { return }
            self.isLoading = false
            switch res {
            case .success(let collection):
                self.collection = collection
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.errorHasOccured = true
                }
            }
        }
    }
}
