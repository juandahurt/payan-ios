//
//  LoginPresenter.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import RxSwift

protocol AnyLoginPresenter: LoginViewOutput, LoginViewInput {
    var interactor: AnyLoginInteractor { get set }
}

protocol LoginViewOutput {
    func login()
}

protocol LoginViewInput {
    var isLoading: PublishSubject<Bool> { get set }
}

final class LoginPresenter: AnyLoginPresenter {
    internal var interactor: AnyLoginInteractor
    
    var isLoading = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    
    init(interactor: AnyLoginInteractor) {
        self.interactor = interactor
    }
    
    func login() {
        isLoading.onNext(true)
        interactor.login()
            .subscribe(
                onSuccess: { [weak self] in
                    self?.isLoading.onNext(false)
                },
                onFailure: { [weak self] _ in
                    self?.isLoading.onNext(false)
                }
            ).disposed(by: disposeBag)
    }
}
