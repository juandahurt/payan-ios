//
//  MapPresenter.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import RxSwift

protocol MapViewInput: ObservableObject {
    var places: [Place] { get }
    var selectedPlace: Place? { get }
}

protocol MapViewOutput {
    func getPlaces()
    func showPlace(_ place: Place)
}

final class MapPresenter: MapViewInput, MapViewOutput, ObservableObject, BasePresenter {
    var router: MapRouter
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    private let interactor: AnyMapInteractor
    private let disposeBag = DisposeBag()
    
    init(interactor: AnyMapInteractor, router: MapRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getPlaces() {
        interactor.getPlaces().observe(on: MainScheduler.instance).subscribe(onSuccess: { [weak self] places in
            guard let self = self else { return }
            self.places = places
        }).disposed(by: disposeBag)
    }
    
    func showPlace(_ place: Place) {
        router.showPlace(place: place)
    }
}
