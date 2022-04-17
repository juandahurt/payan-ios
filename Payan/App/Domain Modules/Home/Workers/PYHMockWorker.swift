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
        let sections = [
            PYHSection(layout: .grid, itemLayout: .collection, items: [PYHSectionItem(),PYHSectionItem(), PYHSectionItem()]),
            PYHSection(layout: .horizontal(260, 160), itemLayout: .innerCard, items: [PYHSectionItem()]),
            PYHSection(layout: .horizontal(140, 140), itemLayout: .basic, items: [PYHSectionItem()])
        ]
        completion(sections)
    }
}
