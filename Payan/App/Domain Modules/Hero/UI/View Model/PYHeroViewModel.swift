//
//  PYHeroViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 14/06/22.
//

import Foundation

class PYHeroViewModel: ObservableObject {
    @Published var hero: PYHero = .empty
    @Published var isLoading = true
    
    private let interactor: PYHeroBusinessLogic
    
    init(interactor: PYHeroBusinessLogic) {
        self.interactor = interactor
    }
    
    func section(at index: Int) -> PYHeroSection {
        hero.sections[index]
    }
    
    func getHero(id: String) {
        interactor.getHero(identifiedBy: id) { [weak self] res in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch res {
                case .success(let hero):
                    self.hero = hero
                case .failure(_): break
                }
            }
        }
    }
}
