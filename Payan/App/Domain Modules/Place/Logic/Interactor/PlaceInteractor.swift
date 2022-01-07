//
//  PlaceInteractor.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import Foundation

protocol AnyPlaceInteractor {
    func logDidEnterEvent(place: Place)
}

final class PlaceInteractor: AnyPlaceInteractor {
    func logDidEnterEvent(place: Place) {
        let event = PlaceAnalyticsEvent.didEnterToPlaceEvent(place: place)
        AnalyticsManager.shared.logEvent(event)
    }
}
