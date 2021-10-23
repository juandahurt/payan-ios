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
    func listFavoritePlaces() -> Single<[Place]>
    func listPlacesByCategory() -> Single<[(PlaceCategory, [Place])]>
}

final class HomeInteractor: AnyHomeInteractor {
    func listFavoritePlaces() -> Single<[Place]> {
        Single.create { single in
            DispatchQueue(label: "", qos: DispatchQoS.background).asyncAfter(deadline: .now() + 2) {
                single(.success(Place.dummyFavorites))
            }
            return Disposables.create()
        }
    }
    
    func listPlacesByCategory() -> Single<[(PlaceCategory, [Place])]> {
        Single.create { single in
            DispatchQueue(label: "", qos: DispatchQoS.background).asyncAfter(deadline: .now() + 1.6) {
                single(.success(
                    [
                        (.museum, Place.dummyMuseums)
                    ]
                ))
            }
            return Disposables.create()
        }
    }
}
