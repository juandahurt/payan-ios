//
//  PYMapAction.swift
//  Payan
//
//  Created by Juan Hurtado on 30/10/22.
//

import Foundation

enum PYMapAction {
    case getLocations
    case setLocations(data: [PYPlaceLocation])
    case selectLocation(location: PYPlaceLocation?)
    case errorOccured
    case requestAuth
}
