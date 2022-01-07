//
//  MapDataManager.swift
//  Payan
//
//  Created by juandahurt on 31/12/21.
//

import Foundation
import RxSwift

protocol MapDataManager {
    func getPlaces() -> Single<[Place]>
}

final class RESTMapDataManager: MapDataManager {
    func getPlaces() -> Single<[Place]> {
        let endpoint = RESTEnpoint<RESTEmptyBody>(path: "place", method: .get, body: nil)
        let response: Single<RESTServerResponse<[Place]>>
        
        response = RESTClient.shared.call(endpoint: endpoint)
        
        return response.map { res -> [Place] in
            return res.data ?? []
        }
    }
}
