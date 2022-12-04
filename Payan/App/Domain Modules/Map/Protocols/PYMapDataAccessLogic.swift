//
//  PYMapDataAccessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 30/10/22.
//

import Combine

protocol PYMapDataAccessLogic {
    func getPlacesLocations() -> AnyPublisher<[PYPlaceLocation], Error>
}
