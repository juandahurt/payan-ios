//
//  PYFeedPresenter.swift
//  Payan
//
//  Created by Juan Hurtado on 8/04/22.
//

import Foundation
import UIKit


class PYFeedPresenter: PYFeedPresentationLogic {
    weak var view: PYFeedViewLogic?
    
    func showLoading() {
        let basicHeader = PYFeedSectionHeader(
            title: ""
        )
        let elementLayout = PYFeedElementLayout(type: .basic, dimensions: nil)
        let elementLayout2 = PYFeedElementLayout(type: .basic, dimensions: .init(width: 240, height: 160))
        let elementLayout3 = PYFeedElementLayout(type: .basic, dimensions: .init(width: 140, height: 250))
        let sections = [
            PYFeedSection(layout: .grid, elementLayout: elementLayout, header: basicHeader, elements: [PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement()]),
            PYFeedSection(layout: .horizontal, elementLayout: elementLayout2, header: basicHeader, elements: [PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement()]),
            PYFeedSection(layout: .horizontal, elementLayout: elementLayout3, header: basicHeader, elements: [PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement(), PYFeedLoadingSectionElement()])
        ]
        view?.renderSections(sections)
    }
    
    func showSections(_ sections: [PYFeedSection]) {
        view?.renderSections(sections)
    }
    
    func showError() {
        view?.showGenericError()
    }
}
