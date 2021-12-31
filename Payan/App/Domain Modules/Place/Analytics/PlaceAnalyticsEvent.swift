//
//  PlaceAnalyticsEvent.swift
//  Payan
//
//  Created by juandahurt on 30/12/21.
//

import Foundation

struct PlaceAnalyticsEvent: AnalyticsEvent {
    var name: String
    var params: [String : Any]?
}

extension PlaceAnalyticsEvent {
    static func didEnterToPlaceEvent(place: Place) -> PlaceAnalyticsEvent {
        PlaceAnalyticsEvent(
            name: "enter_place",
            params: [
                "code": place.code
            ]
        )
    }
}
