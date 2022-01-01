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
}

protocol MapViewOutput {
    func getPlaces()
}

final class MapPresenter: MapViewInput, MapViewOutput, ObservableObject {
    @Published var places: [Place] = []
    private let interactor: AnyMapInteractor
    private let disposeBag = DisposeBag()
    
    init(interactor: AnyMapInteractor) {
        self.interactor = interactor
    }
    
    func getPlaces() {
        interactor.getPlaces().observe(on: MainScheduler.instance).subscribe(onSuccess: { [weak self] places in
            guard let self = self else { return }
            self.places = places
        }).disposed(by: disposeBag)
    }
}
