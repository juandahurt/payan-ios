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
        let loadingCollection = PYLoadingCollection()
        view?.renderCollection(loadingCollection)
    }
    
    func showCollection(_ collection: PYCollection) {
        view?.renderCollection(collection)
    }
}
