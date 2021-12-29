//
//  LaunchDataManager.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation
import RxSwift

protocol AnyLaunchDataManager {
    func getRandomFact() -> Single<Fact>
    func getLatestVersion() -> Single<AppVersion>
}

struct LaunchDataManager: AnyLaunchDataManager {
    func getRandomFact() -> Single<Fact> {
        let endpoint = RESTEnpoint<RESTEmptyBody>(path: "fact", method: .get)
        let response: Single<RESTServerResponse<Fact>>
        
        response = RESTClient.shared.call(endpoint: endpoint)
        return response.map({ res -> Fact in
            if let error = res.error {
                throw error
            }
            
            return res.data!
        })
    }
    
    func getLatestVersion() -> Single<AppVersion> {
        let endpoint = RESTEnpoint<RESTEmptyBody>(path: "app-version/ios", method: .get)
        let response: Single<RESTServerResponse<AppVersion>>
        
        response = RESTClient.shared.call(endpoint: endpoint)
        return response.map({ res -> AppVersion in
            if let error = res.error {
                throw error
            }
            
            return res.data!
        })
    }
}
