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
        let itemLayout = PYFeedItemLayout(type: .basic, dimensions: nil)
        let itemLayout2 = PYFeedItemLayout(type: .basic, dimensions: .init(width: 140, height: 250))
        let itemLayout3 = PYFeedItemLayout(type: .basic, dimensions: .init(width: 140, height: 250))
        let sections = [
            PYFeedSection(layout: .grid, itemLayout: itemLayout, header: basicHeader, items: [PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem()]),
            PYFeedSection(layout: .horizontal, itemLayout: itemLayout2, header: basicHeader, items: [PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem()]),
            PYFeedSection(layout: .horizontal, itemLayout: itemLayout3, header: basicHeader, items: [PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem(), PYFeedLoadingSectionItem()])
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
