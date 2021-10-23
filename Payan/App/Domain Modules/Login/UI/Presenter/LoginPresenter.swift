//
//  LoginPresenter.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginViewOutput {
    var usernameSubject: BehaviorRelay<String?> { get }
    var passwordSubject: BehaviorRelay<String?> { get }
    
    func login()
}

protocol LoginViewInput {
    var loadingPublisher: PublishSubject<Bool> { get }
}

final class LoginPresenter: BasePresenter, LoginViewInput, LoginViewOutput {
    var router: BaseRouter
    private var interactor: AnyLoginInteractor
    private let disposeBag = DisposeBag()
    
    var loadingPublisher = PublishSubject<Bool>()
    var usernameSubject = BehaviorRelay<String?>(value: "")
    var passwordSubject = BehaviorRelay<String?>(value: "")
    
    init(interactor: AnyLoginInteractor, router: LoginRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func login() {
        Observable.combineLatest(usernameSubject, passwordSubject) { [weak self] username, password -> Credential? in
            if let self = self {
                self.loadingPublisher.onNext(true)
                let credential = Credential(username: username ?? "", password: password ?? "")
                return credential
            }
            return nil
        }.flatMap { [weak self] credential -> Single<Void> in
            if let self = self, let credential = credential {
                return self.interactor.login(with: credential)
            }
            return Single.just(())
        }
        .subscribe(
            onNext: { [weak self] in
                if let self = self {
                    self.loadingPublisher.onNext(false)
                }
            }, onError: { [weak self] _ in
                if let self = self {
                    // TODO: show error
                    self.loadingPublisher.onNext(false)
                }
            }
        ).disposed(by: disposeBag)
    }
}
