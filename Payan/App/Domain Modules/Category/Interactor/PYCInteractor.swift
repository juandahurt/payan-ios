//
//  PYCInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


class PYCInteractor: PYCBusinessLogic {
    var places: [PYCPlace]
    var worker: PYCDataAccessLogic
    var presenter: PYCPresentationLogic
    
    init(presenter: PYCPresentationLogic, worker: PYCDataAccessLogic = PYCWorker()) {
        places = []
        self.presenter = presenter
        self.worker = worker
    }
    
    func getPlaces() {
        presenter.showLoading()
        worker.getPlaces { [weak self] places in
            guard let self = self else { return }
            self.places = places
            self.presenter.hideLoading()
            self.presenter.showPlaces()
        }
    }
}
