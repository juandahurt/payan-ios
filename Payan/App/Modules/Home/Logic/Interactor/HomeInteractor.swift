//
//  HomeInteractor.swift
//  Payan
//
//  Created by juandahurt on 16/10/21.
//

import Foundation
import RxSwift

protocol AnyHomeInteractor {
    func listPlaces() -> Single<[Place]>
}

final class HomeInteractor: AnyHomeInteractor {
    func listPlaces() -> Single<[Place]> {
        Single.create { single in
            DispatchQueue(label: "", qos: DispatchQoS.background).asyncAfter(deadline: .now() + 2) {
                single(.success(Place.dummyList))
            }
            return Disposables.create()
        }
    }
}
