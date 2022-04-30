//
//  PYCInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


class PYCInteractor: PYCBusinessLogic {
    var worker: PYCDataAccessLogic
    var presenter: PYCPresentationLogic
    
    init(presenter: PYCPresentationLogic, worker: PYCDataAccessLogic = PYCWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getPlaces(withTypeId typeId: String) {
        presenter.showLoading()
        worker.getPlaces(withTypeId: typeId) { [weak self] res in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.presenter.hideLoading()
                switch res {
                case .success(let collection):
                    self.presenter.showPlaces(collection)
                case .failure(_): break
                }
            }
        }
    }
}
