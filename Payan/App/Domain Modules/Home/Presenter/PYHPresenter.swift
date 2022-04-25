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
        let basicHeader = PYHSectionHeader(
            title: ""
        )
        let itemLayout = PYHItemLayout(type: .basic, dimensions: nil)
        let itemLayout2 = PYHItemLayout(type: .basic, dimensions: .init(width: 140, height: 250))
        let itemLayout3 = PYHItemLayout(type: .basic, dimensions: .init(width: 140, height: 250))
        let sections = [
            PYHSection(layout: .grid, itemLayout: itemLayout, header: basicHeader, items: [PYHLoadingSectionItem(), PYHLoadingSectionItem(), PYHLoadingSectionItem(), PYHLoadingSectionItem()]),
            PYHSection(layout: .horizontal, itemLayout: itemLayout2, header: basicHeader, items: [PYHLoadingSectionItem(), PYHLoadingSectionItem(), PYHLoadingSectionItem(), PYHLoadingSectionItem()]),
            PYHSection(layout: .horizontal, itemLayout: itemLayout3, header: basicHeader, items: [PYHLoadingSectionItem(), PYHLoadingSectionItem(), PYHLoadingSectionItem(), PYHLoadingSectionItem()])
        ]
        view?.renderSections(sections)
    }
    
    func showAppNeedsUpdate(_ type: PYHAppVersionType) {
        var image: UIImage
        var title: String
        var content: String
        var dismissable: Bool
        
        switch type {
        case .optional:
            image = UIImage(named: "logo_info")!
            title = "¡Hay una nueva actualización disponible!"
            content = "Te recomendamos actualizar la app para que puedas disfrutar de la mejor experiencia."
            dismissable = true
        case .mandatory:
            image = UIImage(named: "logo_warn")!
            title = "Lo sentimos."
            content = "Parece que tienes una version desactualizada de la aplicacion. Para que puedas continuar disfrutando de Payan, debes actualizarla."
            dismissable = false
        }
        
        view?.showUpdateModal(
            image: image,
            title: title,
            content: content,
            dismissable: dismissable
        )
    }
    
    func showSections(_ sections: [PYHSection]) {
        view?.renderSections(sections)
    }
}
