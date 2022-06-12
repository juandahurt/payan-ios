//
//  PYCollectionViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 26/05/22.
//

import Foundation

// TODO: maybe use Combine for the loading logic (?)
class PYCollectionViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var collection: PYCollection = .skeleton
    
    var hasReallyLoaded = false {
        didSet {
            if hasFakeLoaded {
                isLoading = false
                setCollection()
            }
        }
    }
    var hasFakeLoaded = false {
        didSet {
            if hasReallyLoaded {
                isLoading = false
                setCollection()
            }
        }
    }
    var cacheCollection: PYCollection?
    let interactor: PYCollectionBusinessLogic
    
    init(interactor: PYCollectionBusinessLogic = PYCollectionInteractor()) {
        self.interactor = interactor
    }
    
    private func setCollection() {
        if let cacheCollection = cacheCollection {
            collection = cacheCollection
        }
    }
    
    func getCollection(ofType type: String, categoryId: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.hasFakeLoaded = true
        }
        interactor.getCollection(ofType: type, categoryId: categoryId) { [weak self] res in
            guard let self = self else { return }
            self.hasReallyLoaded = true
            switch res {
            case .success(let collection):
                self.cacheCollection = collection
            case .failure(_): break
            }
        }
    }
}
