//
//  PYHeroViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 14/06/22.
//

import Foundation

class PYHeroViewModel: ObservableObject {
    @Published var hero: PYHero = .empty
    
    private let interactor: PYHeroBusinessLogic
    
    init(interactor: PYHeroBusinessLogic) {
        self.interactor = interactor
    }
    
    func getHero(id: String) {
        interactor.getHero(identifiedBy: id) { res in
            dump(res)
        }
    }
}
