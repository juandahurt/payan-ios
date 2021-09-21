//
//  LoginInteractor.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import RxSwift

protocol AnyLoginInteractor {
    var authService: AnyAuthService { get set }
    
    func login(with credential: Credential) -> Single<Void>
}

final class LoginInteractor: AnyLoginInteractor {
    var authService: AnyAuthService
    
    private var disposeBag = DisposeBag()
    
    init(authService: AnyAuthService) {
        self.authService = authService
    }
    
    func login(with credential: Credential) -> Single<Void> {
        Single.create { [weak self] single in
            if let self = self {
                self.authService.login(with: credential).subscribe(
                    onSuccess: { token in
                        // TODO: Save current session
                        single(.success(()))
                    },
                    onFailure: { error in
                        single(.failure(error))
                    }
                ).disposed(by: self.disposeBag)
            }
            return Disposables.create()
        }
    }
}
