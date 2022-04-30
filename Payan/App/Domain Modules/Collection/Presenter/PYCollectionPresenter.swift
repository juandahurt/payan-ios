//
//  PYCollectionPresenter.swift
//  Payan
//
//  Created by Juan Hurtado on 9/04/22.
//

import Foundation


class PYCollectionPresenter: PYCollectionPresentationLogic {
    weak var view: PYCollectionViewLogic?
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func showCollection(_ collection: PYCollection) {
        view?.renderCollection(collection)
    }
}
