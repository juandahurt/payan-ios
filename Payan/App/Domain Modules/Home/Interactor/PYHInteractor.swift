//
//  PYHInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation


final class PYHInteractor: PYHBusinessLogic {
    var worker: PYHDataAccessLogic
    var presenter: PYHPresenter
    
    init(presenter: PYHPresenter, worker: PYHDataAccessLogic = PYHWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func checkCurrentVersion() {
        presenter.showLoading()
        worker.getLastVersion { version in
            self.presenter.hideLoading()
            dump(version)
        }
    }
}
