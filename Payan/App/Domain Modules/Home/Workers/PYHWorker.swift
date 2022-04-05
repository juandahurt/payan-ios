//
//  PYHWorker.swift
//  Payan
//
//  Created by Juan Hurtado on 5/04/22.
//

import Foundation
import RxSwift

class PYHWorker {
    func getLastVersion(completion: ((PYHAppVersion) -> Void)?) {
        completion?(PYHAppVersion(number: "1.0.0", type: .mandatory))
//        let endpoint = RESTEnpoint<RESTEmptyBody>(path: "app-version/ios", method: .get)
//        let response: Single<RESTServerResponse<PYHAppVersion>>
//        response = RESTClient.shared.call(endpoint: endpoint)
//        response.subscribe(onSuccess: { res in
//            print(res.data)
//        })
////
//        return response.map({ response in
//            response.data ?? []
//        })
    }
}
