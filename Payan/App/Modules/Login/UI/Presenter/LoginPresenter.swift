//
//  LoginPresenter.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol AnyLoginPresenter: LoginViewOutput, LoginViewInput {
    var interactor: AnyLoginInteractor { get set }
}

protocol LoginViewOutput {
    var username: Observable<String?> { get }
    var password: Observable<String?> { get }
    
    func login()
}

protocol LoginViewInput {
    var isLoading: PublishSubject<Bool> { get set }
}

final class LoginPresenter: AnyLoginPresenter {
    var username: Observable<String?> = Observable.just("")
    var password: Observable<String?> = Observable.just("")
    
    internal var interactor: AnyLoginInteractor
    
    var isLoading = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    init(interactor: AnyLoginInteractor) {
        self.interactor = interactor
    }
    
    func login() {
        Observable.combineLatest(username, password) { [weak self] username, password in
            // TODO: Use username and password
            if let self = self {
                let credential = Credential(username: "john", password: "1234")
                
                self.isLoading.onNext(true)
                self.interactor.login(with: credential)
                    .subscribe(
                        onSuccess: {
                            self.isLoading.onNext(false)
                        },
                        onFailure: { _ in
                            self.isLoading.onNext(false)
                        }
                    ).disposed(by: self.disposeBag)
            }
        }.subscribe()
            .disposed(by: disposeBag)
    }
}
