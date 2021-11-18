//
//  HomeInteractor.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation
import RxSwift

protocol AnyHomeInteractor {
    var dataManager: HomeDataManager { get set }
    
    func listPlacesByCategory() -> Single<[PlaceGroup]>
}

final class HomeInteractor: AnyHomeInteractor {
    var dataManager: HomeDataManager
    
    init(dataManager: HomeDataManager) {
        self.dataManager = dataManager
    }
    
    func listPlacesByCategory() -> Single<[PlaceGroup]> {
        dataManager.listPlacesByCategory()
    }
}
