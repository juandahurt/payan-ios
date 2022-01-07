//
//  MapInteractor.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import RxSwift

protocol AnyMapInteractor {
    func getPlaces() -> Single<[Place]>
}

final class MapInteractor: AnyMapInteractor {
    private let dataManager: MapDataManager
    
    init(dataManager: MapDataManager) {
        self.dataManager = dataManager
    }
    
    func getPlaces() -> Single<[Place]> {
        dataManager.getPlaces()
    }
}
