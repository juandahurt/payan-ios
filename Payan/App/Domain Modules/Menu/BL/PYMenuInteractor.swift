//
//  PYMenuInteractor.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation

class PYMenuInteractor {
    private let state: PYMenuState
    
    init(state: PYMenuState) {
        self.state = state
    }
    
    func getItems() {
        state.items = [.init(image: "help", title: "hola", content: "ayno")]
    }
}
