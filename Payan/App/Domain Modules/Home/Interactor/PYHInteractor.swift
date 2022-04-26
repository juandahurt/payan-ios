//
//  PYHInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation


final class PYHInteractor: PYHBusinessLogic {
    var worker: PYHDataAccessLogic
    var presenter: PYHPresentationLogic
    
    init(presenter: PYHPresenter, worker: PYHDataAccessLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func checkCurrentVersion() {
        presenter.showLoading()
        worker.getLastVersion { [weak self] version in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let currVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    if currVersion < version.number {
                        self.presenter.showAppNeedsUpdate(version.type)
                    }
                }
            }
        }
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
