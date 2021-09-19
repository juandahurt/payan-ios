//
//  AuthService.swift
//  Payan
//
//  Created by juandahurt on 18/09/21.
//

import Foundation
import RxSwift

protocol AnyAuthService {
    func login() -> Single<Void>
}
//observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))

class RemoteAuthService: AnyAuthService {
    func login() -> Single<Void> {
        Console.log("user is logging in", level: .info)
        return Single.create { single in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                Console.log("login successful", level: .info)
                single(.success(()))
            }
            return Disposables.create()
        }
    }
}
