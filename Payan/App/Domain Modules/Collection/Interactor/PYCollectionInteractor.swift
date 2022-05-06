//
//  PYCollectionInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


class PYCollectionInteractor: PYCollectionBusinessLogic {
    var worker: PYCollectionDataAccessLogic
    var presenter: PYCollectionPresentationLogic
    
    init(presenter: PYCollectionPresentationLogic, worker: PYCollectionDataAccessLogic = PYCollectionWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getCollection(withTypeId typeId: String) {
        presenter.showLoading()
        worker.getCollection(withTypeId: typeId) { [weak self] res in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch res {
                case .success(let collection):
                    self.presenter.showCollection(collection)
                case .failure(_):
                    self.presenter.showGenericError()
                }
            }
        }
    }
}
