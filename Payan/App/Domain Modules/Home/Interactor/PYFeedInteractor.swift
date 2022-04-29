//
//  PYFeedInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation


final class PYFeedInteractor: PYFeedBusinessLogic {
    var worker: PYFeedDataAccessLogic
    var presenter: PYFeedPresentationLogic
    
    init(presenter: PYFeedPresenter, worker: PYFeedDataAccessLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getHomeData() {
        presenter.showLoading()
        worker.getData { [weak self] res in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch res {
                case .success(let sections):
                    self.presenter.showSections(sections)
                case .failure(_):
                    self.presenter.showError()
                }
            }
            
        }
    }
}
