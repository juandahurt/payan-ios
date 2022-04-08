//
//  PYHPresenter.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation
import UIKit


class PYHPresenter: PYHPresentationLogic {
    weak var view: PYHViewLogic?
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func showAppNeedsUpdate(_ type: PYHAppVersionType) {
        view?.showModal()
    }
}
