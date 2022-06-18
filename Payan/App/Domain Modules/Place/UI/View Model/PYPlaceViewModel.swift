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
    
    var tabTitles: [String] {
        var titles = ["Ubicación"]
        if !place.images.isEmpty {
            titles.append("Imágenes")
        }
        return titles
    }
    
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
