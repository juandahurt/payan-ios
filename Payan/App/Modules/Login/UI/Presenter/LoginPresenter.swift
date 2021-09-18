//
//  LoginPresenter.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation

protocol AnyLoginPresenter: LoginViewOutput {
    var interactor: AnyLoginInteractor { get set }
}

protocol LoginViewOutput {
    func login()
}
// TODO: Add login view input protocol

final class LoginPresenter: AnyLoginPresenter {
    internal var interactor: AnyLoginInteractor
    
    init(interactor: AnyLoginInteractor) {
        self.interactor = interactor
    }
}

extension LoginPresenter: LoginViewOutput {
    func login() {
        interactor.login()
    }
}
