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
    @Published var errorHasOccured = false
    @Published var placeWasFetchedSuccesffully = false
    @Published var currentImageIndex = 0
    
    var images: [String] {
        let rawImages = place.images.map { $0.url }
        var result = [place.image]
        result.append(contentsOf: rawImages)
        return result
    }
    
    init(interactor: PYPlaceBusinessLogic = PYPlaceInteractor()) {
        self.interactor = interactor
    }
    
    func getPlace(id: String) {
        isLoading = true
        interactor.getPlace(identifiedBy: id) { [weak self] res in
            guard let self = self else { return }
            self.isLoading = false
            switch res {
            case .success(let place):
                self.place = place
                self.placeWasFetchedSuccesffully = true
            case .failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.errorHasOccured = true
                }
            }
        }
    }
}
