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
    
    var cachePlace: PYPlace?
    var hasReallyLoaded = false {
        didSet {
            if hasFakeLoaded {
                isLoading = false
                setPlace()
            }
        }
    }
    var hasFakeLoaded = false {
        didSet {
            if hasReallyLoaded {
                isLoading = false
                setPlace()
            }
        }
    }
    
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
    
    private func setPlace() {
        if let cachePlace = cachePlace {
            place = cachePlace
        }
    }
    
    func getPlace(id: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.hasFakeLoaded = true
        }
        interactor.getPlace(identifiedBy: id) { [weak self] res in
            guard let self = self else { return }
            self.hasReallyLoaded = true
            switch res {
            case .success(let place):
                self.cachePlace = place
            case .failure(_): break
            }
        }
    }
}
