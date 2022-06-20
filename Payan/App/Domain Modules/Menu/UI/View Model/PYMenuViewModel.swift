//
//  PYMenuViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 20/06/22.
//

import Foundation

class PYMenuViewModel: ObservableObject {
    @Published var items: [PYMenuItem] = PYMenuItem.defaultItems
    @Published var selectedItem: PYMenuItem?
    
    func select(item: PYMenuItem) {
        selectedItem = item
    }
}
