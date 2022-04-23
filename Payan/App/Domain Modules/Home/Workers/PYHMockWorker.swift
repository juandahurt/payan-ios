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
    
    func getData(completion: @escaping ([PYHSection]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let headerWithButton = PYHSectionHeader(
                title: "Universidades",
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
                PYHSection(layout: .grid, itemLayout: .collection, header: headerWithSubtitle, items: [PYHSectionItem(),PYHSectionItem(), PYHSectionItem(), PYHSectionItem()]),
                PYHSection(layout: .horizontal(140, 250), itemLayout: .basic, header: basicHeader, items: [PYHSectionItem(), PYHSectionItem(), PYHSectionItem(), PYHSectionItem()]),
                PYHSection(layout: .horizontal(260, 160), itemLayout: .innerCard, header: headerWithButton, items: [PYHSectionItem()]),
            ]
            completion(sections)
        }
    }
}
