//
//  PlacePresenter.swift
//  Payan
//
//  Created by juandahurt on 15/11/21.
//

import Foundation

protocol PlaceViewInput {
    var selectedPlace: PlaceDetails { get }
}

protocol PlaceViewOutput {
    func didEnter()
    func dismiss()
}

final class PlacePresenter: BasePresenter {
    var router: PlaceRouter
    private var interactor: AnyPlaceInteractor
    private var place: Place
    
    init(place: Place, router: PlaceRouter, interactor: AnyPlaceInteractor) {
        self.place = place
        self.router = router
        self.interactor = interactor
    }
}


extension PlacePresenter: PlaceViewInput {
    var selectedPlace: PlaceDetails {
        PlaceDetails(
            name: place.name,
            code: place.code,
            imageUrl: place.imageUrl,
            description: place.description,
            foundationYear: place.foundationYear
        )
    }
}


extension PlacePresenter: PlaceViewOutput {
    func didEnter() {
        interactor.logDidEnterEvent(place: place)
    }
    
    func dismiss() {
        router.dismiss()
    }
}
