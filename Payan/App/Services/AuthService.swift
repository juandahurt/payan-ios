//
//  AuthService.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import Foundation
import RxSwift
import RxAlamofire

protocol AnyAuthService {
    func login(with credential: Credential) -> Single<String>
}

final class RemoteAuthService: AnyAuthService {
    private let disposeBag = DisposeBag()
    
    func login(with credential: Credential) -> Single<String> {
        let endpoint = RESTAPIAuth.login
        let url = URL(string: endpoint.path)!
        
        return Single.create { single in
            let observable: Observable<(HTTPURLResponse, RESTAPIResponse<String>)> = RxAlamofire.requestDecodable(endpoint.method, url)
            observable
                .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                .subscribe(onNext: { (status, response) in
                    Console.log("server response: \(response)", level: .debug)
                    if response.success {
                        single(.success(response.data!))
                    } else {
                        single(.failure(response.error!))
                    }
                }, onError: { error in
                    Console.log("unexpected error: \(error)", level: .error)
                    single(.failure(error))
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
