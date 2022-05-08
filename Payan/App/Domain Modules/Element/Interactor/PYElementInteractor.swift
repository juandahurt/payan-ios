//
//  PYElementInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementInteractor: PYElementBusinessLogic {
    var presenter: PYElementPresentationLogic
    
    init(presenter: PYElementPresentationLogic) {
        self.presenter = presenter
    }
    
    func getElementData() {
        presenter.showLoading()
    }
}
