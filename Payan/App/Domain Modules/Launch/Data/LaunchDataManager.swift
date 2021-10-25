//
//  LaunchDataManager.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation
import RxSwift

protocol AnyLaunchDataManager {
    func getLatestVersion() -> Single<AppVersion>
}

struct LaunchDataManager: AnyLaunchDataManager {
    private var disposeBag = DisposeBag()
    
    func getLatestVersion() -> Single<AppVersion> {
        Single.create { single in
            let disposable = Disposables.create()
            let endpoint = RESTEnpoint<RESTEmptyBody>(path: "app-version/ios", method: .get)
            let response: Single<RESTServerResponse<AppVersion>>
            
            response =  RESTClient.shared.call(endpoint: endpoint)
            response.subscribe(
                onSuccess: { res in
                    single(.success(res.data!))
                },
                onFailure: { err in
                    single(.failure(err))
                }
            ).disposed(by: disposeBag)
            
            return disposable
        }
    }
}
