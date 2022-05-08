//
//  PYElementInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementInteractor: PYElementBusinessLogic {
    var presenter: PYElementPresentationLogic
    var worker: PYElementDataAccessLogic
    
    init(presenter: PYElementPresentationLogic, worker: PYElementDataAccessLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getElementData(id: String) {
        presenter.showLoading()
        worker.getElementData(id: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let sections):
                    self.presenter.showSections(sections)
                case .failure(_):
                    #warning("TODO: show generic error")
                }
            }
        }
    }
}
