//
//  PYPlaceViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 28/05/22.
//

import Foundation

class PYPlaceViewModel: ObservableObject {
    let interactor: PYPlaceBusinessLogic
    
    @Published var place: PYPlace = .empty
    @Published var isLoading = true
    @Published var location = PYPlaceLocation(lat: 2.443881, lon: -76.605059)
    
    init(interactor: PYPlaceBusinessLogic = PYPlaceInteractor()) {
        self.interactor = interactor
    }
    
    func getPlace(id: String) {
        interactor.getPlace(identifiedBy: id) { [weak self] res in
            guard let self = self else { return }
            self.isLoading = false
            switch res {
            case .success(let place):
                self.place = place
            case .failure(_): break
            }
        }
    }
}
