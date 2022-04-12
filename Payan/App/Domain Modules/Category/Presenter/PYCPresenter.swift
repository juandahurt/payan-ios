//
//  PYCPresenter.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


class PYCPresenter: PYCPresentationLogic {
    weak var view: PYCViewLogic?
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func showPlaces() {
        view?.updatePlacesTable()
    }
}
