//
//  HomeInteractor.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation
import RxSwift

// TODO: Create place services

protocol AnyHomeInteractor {
    var dataManager: HomeDataManager { get set }
    
    func listFavoritePlaces() -> Single<[Place]>
    func listPlacesByCategory() -> Single<[PlaceGroup]>
}

final class HomeInteractor: AnyHomeInteractor {
    var dataManager: HomeDataManager
    
    init(dataManager: HomeDataManager) {
        self.dataManager = dataManager
    }
    
    func listFavoritePlaces() -> Single<[Place]> {
        Single.create { single in
            DispatchQueue(label: "", qos: DispatchQoS.background).asyncAfter(deadline: .now() + 2) {
                single(.success(Place.dummyFavorites))
            }
            return Disposables.create()
        }
    }
    
    func listPlacesByCategory() -> Single<[PlaceGroup]> {
        dataManager.listPlacesByCategory()
//        Single.create { single in
//
//            return Disposables.create()
//        }
    }
}
