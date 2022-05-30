//
//  PYPlaceViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation

class PYPlaceViewModel: ObservableObject {
    @Published var place: PYPlace = .empty
    let interactor: PYPlaceBusinessLogic
    
    init(interactor: PYPlaceBusinessLogic = PYPlaceInteractor()) {
        self.interactor = interactor
    }
    
    func getPlace(id: String) {
        interactor.getPlace(identifiedBy: id) { [weak self] res in
            guard let self = self else { return }
            switch res {
            case .success(let place):
                self.place = place
            case .failure(_): break
            }
        }
    }
}
