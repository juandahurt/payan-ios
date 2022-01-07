//
//  HomeDataManager.swift
//  Payan
//
//  Created by juandahurt on 9/11/21.
//

import Foundation
import RxSwift

protocol HomeDataManager {
    func listPlacesByCategory() -> Single<[PlaceGroup]>
}

struct RESTHomeDataManager: HomeDataManager {
    private let disposeBag = DisposeBag()
    
    func listPlacesByCategory() -> Single<[PlaceGroup]> {
        let endpoint = RESTEnpoint<RESTEmptyBody>(path: "place?group=1", method: .get)
        let response: Single<RESTServerResponse<[PlaceGroup]>>
        
        response = RESTClient.shared.call(endpoint: endpoint)
        
        return response.map({ response in
            response.data ?? []
        })
    }
}
