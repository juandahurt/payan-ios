//
//  PYOnboardingViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 30/07/22.
//

import Foundation
import Purace

class PYOnboardingViewModel: ObservableObject {
    @Published var currentIndex: Int
    @Published var items: [PYOnboardingItem]
    
    let interactor: PYOnbardingInteractor
    
    init(interactor: PYOnbardingInteractor) {
        self.interactor = interactor
        currentIndex = 0
        items = []
    }
    
    var buttonText: String {
        currentIndex == items.count-1 ? "Continuar" : "Siguiente"
    }
    
    var mainButtonType: PuraceButtonType {
        if currentIndex == items.count-1 {
            return .loud
        }
        return .custom(.clear, PuraceStyle.Color.N8, PuraceStyle.Color.N1)
    }
    
    func item(at index: Int) -> PYOnboardingItem {
        items[index]
    }
    
    func next() {
        interactor.next(currentIndex: &currentIndex, numberOfItems: items.count)
    }
    
    func getData() {
        items = interactor.getItems()
        print(items)
    }
}
