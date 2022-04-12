//
//  PYHWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation
import RxSwift

#warning("TODO: remove RxSwift dependency")
class PYHWorker: PYHDataAccessLogic {
    private let disposeBag = DisposeBag()
    
    func getLastVersion(completion: ((PYHAppVersion) -> Void)?) {
        let endpoint = RESTEnpoint<RESTEmptyBody>(path: "app-version/ios", method: .get)
        let response: Single<RESTServerResponse<PYHAppVersion>>
        response = RESTClient.shared.call(endpoint: endpoint)
        response.subscribe(onSuccess: { res in
            completion?(res.data!)
        }).disposed(by: disposeBag)
    }
}
