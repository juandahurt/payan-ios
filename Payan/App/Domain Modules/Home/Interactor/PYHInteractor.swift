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
    
    func checkCurrentTime() {
        let calender = Calendar.current
        let date = Date()
        let hour = calender.component(.hour, from: date)
        
        var time: PYHTime
        if hour < 12 {
            time = .day
        } else if hour >= 12 && hour <= 18 {
            time = .afternoon
        } else {
            time = .night
        }
        
        presenter.showCurrentTime(time)
    }
}
