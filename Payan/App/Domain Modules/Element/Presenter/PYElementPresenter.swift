//
//  PYElementPresenter.swift
//  Payan
//
//  Created by Juan Hurtado on 7/05/22.
//

import Foundation

class PYElementPresenter: PYElementPresentationLogic {
    weak var view: PYElementViewLogic?
    
    func showLoading() {
        let sections = [
            PYElementSection(itemLayout: .image, items: [PYElementSectionLoadingItem()])
        ]
        view?.renderSections(sections)
    }
    
    func showSections(_ sections: [PYElementSection]) {
        view?.renderSections(sections)
    }
}
