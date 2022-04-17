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
    
    init(presenter: PYHPresenter, worker: PYHDataAccessLogic = PYHWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func checkCurrentVersion() {
        presenter.showLoading()
        worker.getLastVersion { [weak self] version in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.presenter.hideLoading()
                if let currVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    if currVersion < version.number {
                        self.presenter.showAppNeedsUpdate(version.type)
                    }
                }
            }
        }
    }
    
    func getHomeData() {
        worker.getData { [weak self] sections in
            guard let self = self else { return }
            self.presenter.showSections(sections)
        }
    }
}
