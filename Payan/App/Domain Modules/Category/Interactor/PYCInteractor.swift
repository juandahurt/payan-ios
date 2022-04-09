//
//  PYCInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


class PYCInteractor: PYCBusinessLogic {
    var places: [String]
    var presenter: PYCPresentationLogic
    
    init(presenter: PYCPresentationLogic) {
        places = []
        self.presenter = presenter
    }
    
    func getPlaces() {
        presenter.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.places = ["", "", ""]
            self.presenter.hideLoading()
            self.presenter.showPlaces()
        }
    }
}
