//
//  LoginInteractor.swift
//  Payan
//
//  Created by juandahurt on 15/09/21.
//

import Foundation
import RxSwift

protocol AnyLoginInteractor {
    var remoteDataManager: RemoteLoginDataManager { get set }
    var localDataManager: LocalLoginDataManager { get set }
    
    func login(with credential: Credential) -> Single<Void>
}

final class LoginInteractor: AnyLoginInteractor {
    var remoteDataManager: RemoteLoginDataManager
    var localDataManager: LocalLoginDataManager
    
    private var disposeBag = DisposeBag()
    
    init(remoteDataManager: RemoteLoginDataManager, localDataManager: LocalLoginDataManager) {
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
    }
    
    func login(with credential: Credential) -> Single<Void> {
        remoteDataManager.login(using: credential)
            .do(onSuccess: { [weak self] token in
                let session = UserSession(token: token)
                self?.localDataManager.saveSession(session)
            })
            .map({ _ in })
    }
}
