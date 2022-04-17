//
//  PYHMockWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 17/04/22.
//

import Foundation


class PYHMockWorker: PYHDataAccessLogic {
    func getLastVersion(completion: ((PYHAppVersion) -> Void)?) {
        
    }
    
    func getData(completion: ([PYHSection]) -> Void) {
        let headerWithButton = PYHSectionHeader(
            title: "Universidaddes",
            secondaryButton: PYHHeaderButton(title: "Ver todas")
        )
        let basicHeader = PYHSectionHeader(
            title: "Próceres"
        )
        let headerWithSubtitle = PYHSectionHeader(
            title: "Lugares",
            subtitle: "Andentrate en la ciudad blanca"
        )
        let sections = [
            PYHSection(layout: .horizontal(140, 250), itemLayout: .basic, header: headerWithButton, items: [PYHSectionItem(), PYHSectionItem(), PYHSectionItem(), PYHSectionItem()]),
            PYHSection(layout: .horizontal(260, 160), itemLayout: .innerCard, header: headerWithSubtitle, items: [PYHSectionItem()]),
            PYHSection(layout: .grid, itemLayout: .collection, header: basicHeader, items: [PYHSectionItem(),PYHSectionItem(), PYHSectionItem()]),
        ]
        completion(sections)
    }
}
