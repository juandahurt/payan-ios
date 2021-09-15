//
//  LoginPresenter.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation

protocol AnyLoginPresenter {
    var interactor: AnyLoginInteractor { get set }
}

final class LoginPresenter: AnyLoginPresenter {
    var interactor: AnyLoginInteractor
    
    init(interactor: AnyLoginInteractor) {
        self.interactor = interactor
    }
}
