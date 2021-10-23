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
    
    func login(with credential: Credential) -> Single<Void>
}

final class LoginInteractor: AnyLoginInteractor {
    var remoteDataManager: RemoteLoginDataManager
    
    private var disposeBag = DisposeBag()
    
    init(remoteDataManager: RemoteLoginDataManager) {
        self.remoteDataManager = remoteDataManager
    }
    
    func login(with credential: Credential) -> Single<Void> {
        remoteDataManager.login(using: credential)
            .do(onSuccess: { token in
                // TODO: Save current session
                Console.log("token: \(token)", level: .debug)
            })
            .map({ _ in
                
            })
    }
}
