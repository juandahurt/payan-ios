//
//  PlacePresenter.swift
//  Payan
//
//  Created by juandahurt on 15/11/21.
//

import Foundation

protocol PlaceViewInput {
    var selectedPlace: Place { get }
}

final class PlacePresenter: BasePresenter {
    var router: PlaceRouter
    private var place: Place
    
    init(place: Place, router: PlaceRouter) {
        self.place = place
        self.router = router
    }
}

// MARK: - Input
extension PlacePresenter: PlaceViewInput {
    var selectedPlace: Place {
        place
    }
}
