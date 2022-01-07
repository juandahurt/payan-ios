//
//  LoginDataManager.swift
//  Payan
//
//  Created by juandahurt on 23/10/21.
//

import Foundation
import RxSwift

protocol RemoteLoginDataManager {
    func login(using credential: Credential) -> Single<String>
}

struct RESTLoginDataManager: RemoteLoginDataManager {
    private var disposeBag = DisposeBag()
    
    func login(using credential: Credential) -> Single<String> {
        Single.create { single in
            let endoint = RESTEnpoint(path: "auth/signIn", method: .post, body: credential)
            let response: Single<RESTServerResponse<String>>
            
            response = RESTClient.shared.call(endpoint: endoint)
            response.subscribe(
                onSuccess: { res in
                    single(.success(res.data!))
                },
                onFailure: { err in
                    single(.failure(err))
                }
            ).disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
}
